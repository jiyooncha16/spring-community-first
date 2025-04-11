package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.FileCopyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;



@Log4j
//@RequestMapping("/upload") // /board/로 시작하는 모든 처리를 BoardController가 하도록 지정함
//@AllArgsConstructor // BoardSercive에 의존적이므로 생성자 만들어 자동 주입
@Controller // 스프링의 빈으로 인식
public class UploadController {
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/upload", produces=MediaType.APPLICATION_JSON_UTF8_VALUE) //리스트 반환
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> upload(MultipartFile[] uploadFile) {
		
		List<BoardAttachVO> list = new ArrayList<>();
			
		String uploadFolder = "C:/upload"; //저장경로
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info(uploadPath);
		if (uploadPath.exists() == false) { //c:/upload에 연월일 폴더가 존재하지 않으면 
			uploadPath.mkdirs(); // 새 경로(폴더) 생성
		}
		
		
		for (MultipartFile multipartFile : uploadFile) { // 파일마다
			
			BoardAttachVO vo = new BoardAttachVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("/원래의 파일명: " + uploadFileName);
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); // 뒤의 이름을 파일이름으로 저장 (IE 관련)
			log.info("/이후의 파일명: " + uploadFileName);
			vo.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; // 업로드할 파일명 (uuid_본파일명)
		
			
			try {
				File saveFile = new File(uploadPath, uploadFileName); //저장경로, 파일 이름 지정하여
				multipartFile.transferTo(saveFile); // 저장 (transferTo 메서드)
				
				vo.setUuid(uuid.toString());
				log.info("uuid: " + vo.getUuid());
				vo.setUploadPath(uploadFolderPath);
				log.info("UploadPath: " + vo.getUploadPath());
				
				if (checkImageType(saveFile)) {
					vo.setFileType(true); //이미지 여부 확인 후 저장
					log.info("Image?: " + vo.isFileType());
					//썸네일 작업
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName)); // 썸네일은 앞에 s_를 붙임
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(vo);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}//for
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}// /upload
	
	private String getFolder() { // 연월일 폴더 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);

		//return str.replace("-", File.separator);
		return str.replace("-", "/");
	}

	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("checking image : " + contentType);
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName); // 파일명
		File file = new File("c:\\upload\\" + fileName);
		log.info("file: " + file); // 파일 경로
		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath())); // 콘텐트 타입을 헤더에 추가
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK); //file을 바이트 배열에 담기
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result; // file을 담은 바이트 배열 반환
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);
		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8")); // 전달받은 이름의 파일 삭제
			file.delete();

			if (type.equals("image")) { // 이미지일 경우 썸네일도 삭제
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("Thumbnail name: " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
	
	// 파일 다운로드 메서드
	// 로직 : 요청받은 파일명을 리소스 객체에 저장 - 저장할 이름과 attachment(다운로드) 속성을 content-dispotion 헤더에 담아서 200 ok 상태와 함께 리턴
	//  --> 브라우저가 받아서 다운로드 처리
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, @RequestParam("file") String fileName) {
		
		log.info("fileName: " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName); // 해당 파일을 리소스 객체에 저장

		if (resource.exists() == false) { // 파일명이 없으면 not found 상태 반환
			log.info("resource do not exist");
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		log.info("resource name: " + resource.getFilename());

		String resourceName = resource.getFilename(); //리소스 객체의 파일명 추출 (기존 FileName 쓸 수 있지만, 그건 클라이언트가 건들 수 있으므로 보안 위해 새로 추출)
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1); //파일명에서 uuid 제거
		HttpHeaders headers = new HttpHeaders(); // http 객체 생성
		
		try { //user agent 정보로 IE인지 확인
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
			String downloadName = null;
			
			//인코딩 for 한글이름
			if (checkIE) { // IE인 경우 파일명을 UTF-8로 인코딩 후 공백 처리
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
			} else { // 아닐 경우 ISO-8859-1로 인코딩
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			} // 다운로드 시 Content-Disposition 헤더 추가 (attachment, 즉 다운로드할 파일임을 지정 + 다운로드 파일명 지정)
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) { // 인코딩 에러 시
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK); // 다운로드할 파일, 어떤 파일인지(다운로드해야하는지, 띄워야 하는지) 판단 위한 헤더, 상태 전송
	}



}//controller
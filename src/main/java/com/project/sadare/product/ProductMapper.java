package com.project.sadare.product;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductMapper {

//	제품등록 => 대표이미지, 세부이미지 *2
	void insert(Product p);

//	제품 목록의 전체 개수를 가져옴
	int selectListSize();

//	제품 상세보기
	Product select(int product_num);

//	전체 제품 목록
	ArrayList<Product> selectList();

//	원하는 개수만큼 가져오기
	ArrayList<Product> selectListByLimit(int start, int last);

//	제품 검색
	ArrayList<Product> selectListByProduct_name(String product_name);

//	카테고리별 검색
	ArrayList<Product> selectListByCategory1_num(int category1_num);

	ArrayList<Product> selectListByCategory2_num(int category2_num);

	ArrayList<Product> selectListByCategory3_num(int category3_num);

//	회원이 등록한 제품 보기
	ArrayList<Product> selectListByUser_id(String user_id);

//	제품 내용 수정
	void update(Product p);

//	조회수 추가
	void updateHit(int product_num);

//	제품 거래결과 수정 (판매중/판매완료)
	void updateResult(int product_num, int product_result);

//	제품 삭제
	void delete(int product_num);

//	현재 시퀀스 값 가져오기
	int selectSeqCurrval();

}

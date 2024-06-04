Return-Path: <linux-kernel+bounces-201198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186948FBACB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ACF1F23476
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E914A4F3;
	Tue,  4 Jun 2024 17:42:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7E14EC40
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522972; cv=fail; b=FtFX5grOGwnm35JyouP8BfMH4/Cl38U1VikNK9Z/b6/Aj3oySLDG9siL4AmnuisrtW5k+oK/HuFyPjVaWn0spA+jcpipZgj8m/6dyO2wDOz6sow8+7jEIwjV9tR14IBgebsMMKMfJ0e82bJVlV44oTz4JRil9kHKUh3EgwKdeQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522972; c=relaxed/simple;
	bh=yFgI5wZicJi+A0srqZeBYBTdhTU3OD8SXqkCWczeL/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0D4CM1EMJCvOiQQgktAH/BWCKv3wjzDdZRHNlaA2H21FRSuQ1dmnU/aSwh/g3t+SOJR4+1L5xzEGuESLHe5VoHLc/1FclTULqsFMs9xy6Z+9RrB6N+RrjW0irQPhXdyHW1KBuR0TAkqifZshHx1XFrV7AFraI+D4UpJkd3sjYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BmoPB013712;
	Tue, 4 Jun 2024 17:42:33 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D/axvbuW8khhoVEyMPhrQgsnIMUV1XCKocXZ29JyAv1E=3D;_b?=
 =?UTF-8?Q?=3DFqeNTKLDyd3Qz9ctX6mzBfYdl/yjrF15aSUWmAGSeEmdUGj7O9wJH3gDqwko?=
 =?UTF-8?Q?KVGWl5Ht_l5WOFBhunHkze6VyccJ6uIj+wk4EsEk65AWlfsJh8x96AEjKR/7df1?=
 =?UTF-8?Q?cI4Jf1N75AMbBw_HrZAHPd38oPoAjb0HEs73/BnpP7lVAfHZOLt4abOqJJyShtS?=
 =?UTF-8?Q?RcQzda6Xx7q8HUMt9YcW_zot2mghC9O/BbiyNfXpCLqwvnozyeKLhpqtTFJakNa?=
 =?UTF-8?Q?F4BlrqZU43AgbiKHUlbYJP3+SP_0f9yBi0vUKhGyTc/QFRpQ8VsxrVjR1ZfIVix?=
 =?UTF-8?Q?BJ2HS2V+TwSK9YXfiGgzJG46cimb8esp_bA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm5jrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HW4DG016141;
	Tue, 4 Jun 2024 17:42:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf3dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFmhjP+pH2PLlpTAIjwP8sBusL9t0gVpWc6Y/dVTsbYP+jB3XwxM36oK/O8FQUjbGgihHe534Ou4EOh8EjqoOex0jD1Y3qM8BhfoASpsQHZAusLVdpLLaNwl9orLNCUyirazIxGCSouIfz3Sj6xTCCnn3Sk9nqlv4VvqhaL6T/r9lOrAfgqTYP73aeXwG7t7vdCDuW3Ykvb8mEXjwc2Mp1EpOuNeDSh7CvpUHKd8HKC4cE1MyywfReJHESyQLNWsq2ouW3U8b08Rc23eO3ydSZMP0jR8udChJA/1eN5yjZnSMWLyB9NcFDfhJo8KARSUp8MAbd5jHJW42Ru9+Wq4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/axvbuW8khhoVEyMPhrQgsnIMUV1XCKocXZ29JyAv1E=;
 b=KfnTjjQ2Gk7796y4X3fN0VB9z7n7eal1cuAQCLamVwWTHsk2OAtmhS0LXYenO6X6ROOUzemLOjMEO0Yt+4HGhsjTM76bqDOYpjycJEA7ok/dvA1bFkhT4uA+SHw/rSkS8rLcXNeMWmsePi83CvawOENBm/EtqnWJqMX2mNFafKhTm4gpp2ZVNlOAeVXs3R0AV9EgXx+hbk4hK7wcseXwmAVLiYPd9zONpZu/beiK/611EhD+OUiMTrnRSHHDCqIIXrgjB9X0b+wLEdggsGadyRLv0En8XqJQHMogcmkckCY7uTRBRqupP2+CCzdlaKJNOpakHVJUxEHoTw7IpcLU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/axvbuW8khhoVEyMPhrQgsnIMUV1XCKocXZ29JyAv1E=;
 b=H0d9RaWIb0Mrw+7vx0h1rwT72pQtdnuFMAQJSZeKl10TfzZzwIxgQLS1TfmJDg6aCvWL/oe64K+VBAxgiHqm/wXdI4XiZwSzSpYoDlGGS/nyVD2gP4d8wP8l+Ep3neegxVuTAllCtL78joqwSqCU+kECm402vvUm3myXvo1stY8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 17:42:30 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:30 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 18/18] maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()
Date: Tue,  4 Jun 2024 10:41:45 -0700
Message-ID: <20240604174145.563900-19-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1b2a79-7cbc-4d59-d95c-08dc84bdb511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4JvesdLVzHDvKx/UsmwaAyB9tozbNNdyDOvqpt17AFVnalB83nu2gH3Jd9zs?=
 =?us-ascii?Q?5+Sl+9YfZb03YNuWWlR0MoBadJG4n3qVNymch65Kd9q/K29t1rOwqJvXdIB7?=
 =?us-ascii?Q?dllit98fvMEULjLMDgv1lh22bubZwtjEUiVDBiqDUBDbAtFMcgSm/3Pd8ekc?=
 =?us-ascii?Q?uSm+S9tSk2GEHeRElgPo8HDyjvY30uWbPgwblfgT8EAIfNZC47Y+xGhocby/?=
 =?us-ascii?Q?RfS1mDckIskrfILQ5+z/7zCjQDFDyUPCRCGM57/a8vQqufi9SSzqoDo51CF0?=
 =?us-ascii?Q?aR4J5v6N3ybPW7vhEjZBbPQlrc+rHG/RjLI0HHjqOQYTJOHtnLfhpQsn2VAS?=
 =?us-ascii?Q?J/3RzFu2MReKwgBJ//rBghwhyZRnRQquOge3BTEaDbIqoppeXT3si7DHBRgo?=
 =?us-ascii?Q?TNa8o8RCg3jyNxpdMnQZyOGhF2U9/sPUyWxdlWvYSFp9GPyYjhtGVnHv/Muv?=
 =?us-ascii?Q?G8hd+3wamSLXLQhZ9nff9EtupKI7hKantLi2V7bTjpANkOjounHxf8SoX0Kl?=
 =?us-ascii?Q?KjFcAewDs9hRy+GgFG+jZYu/4r7OwiCNGLiPBRFDtPJ5tYVofyY/O6UnwGic?=
 =?us-ascii?Q?xZhkliDOZZKmZc/Jr+6v2qDNq1e/gA29pTbtxQ383ikB305EvyG/Ia6M4Iwe?=
 =?us-ascii?Q?EfVC3Igqa5KAAtTuspAUM0sK+v6nxdO3BZcA2yECJuJ5c3Hy/lUcq7Eo/Qu4?=
 =?us-ascii?Q?1bhEOtwinTfL18FLaaM+0u06iT2aezfkqoR45xLsXHsS3LidcfHV89VmEjpR?=
 =?us-ascii?Q?EZxPaQSB1Med2S279F49qHbvAKhump4Tww9FcHzlXdfgLMqDeW98mxn9lwXJ?=
 =?us-ascii?Q?ApIzg9k2EFuBXLwltdFQhmLxKC2DLfYrsxCrgNyEXKnEoWEjvDW4LFibjN/Z?=
 =?us-ascii?Q?PaD8lnWMCdQlPK2i0TOrmUn/3MQPdNzZNQQAHaX61P4dCp62VCYPr4ScaURY?=
 =?us-ascii?Q?4Slo4HgcD94LI+VmA3+93AjVA/xOPa6xSGRZnP6ck5kmOYAkqZf67kFgaUeT?=
 =?us-ascii?Q?tYegJ/vFNdKe4SWnQjPmy0wX2SiS8aXQXii0zDV5MuzLMt23NblEZle/A5if?=
 =?us-ascii?Q?E3OAVbHOJMGUe3LeEsbNYwNI46/DSBxUaAzNHh/ox5lwceYCuemYMWJejrD6?=
 =?us-ascii?Q?SlzWDJEPkka7zZBqEh+/Qlih9Og8ocoA6Dyd61L9A006ksZsyH+PmmdGohEn?=
 =?us-ascii?Q?XSlV5tZAPlfPM0llwKNwexZZICMcHtAWUQzp4nYnUM8PuT1SM626pNNxZu4P?=
 =?us-ascii?Q?bOlEhcCOPGtPXRiSpRX9QuVTIcGno7/URgBkn3eG9w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ycagm2bgr6iZ/tQh0OMuZdS8BNzS3JiTBIjdFISc+jq7SI/6YPOOyCHjSKoq?=
 =?us-ascii?Q?vetVaEAJM9aNGJeyFUcSkvMcoqsytWgbKzxddhE0eBnpigl54S5aYvAiT6pS?=
 =?us-ascii?Q?rEl2qPQgl7kE98jxgy7hpAP6rR+9KCG8fcJ6qUOCNw5QUNVO8O0EJ+KcqDI3?=
 =?us-ascii?Q?KDwbCpgsRB+eAMM1tpJWVOZdxpeQOUktQOv7XofnlrVj2M/a4Lz53FUD0cl9?=
 =?us-ascii?Q?ApYYfqRTz6TgX+K/BHSovmDHOx8lMRviT1MZURlK4zIYonDsvRh1qb0/Me63?=
 =?us-ascii?Q?M84UmC0hQDBcVhEWLulGQQNKNFAyO9KR617LyNLZmAjwtB23BjGEg7mhUx0x?=
 =?us-ascii?Q?Wge+No1fWRiOw0sQYG/hY4AKPUDrSxu8aOyFlTITxsnHwLBN6QbbArpbW5ku?=
 =?us-ascii?Q?2aQ5PbetoGrldwxThKJpgzDTOud4iFB2a4yeaIC1z3qkx5qUOmCfX9HKU3d/?=
 =?us-ascii?Q?Zpumue97O1/vfBVt8RTEIXKOI5ZB/SpOmLJEWensJ4AFaqCnvpRCMD/ITYQm?=
 =?us-ascii?Q?K3+dQ579/+X5TaYjKKNmDg0PY8E/89RMKFKLFs61/K1KGgdzFgg0FNdMp091?=
 =?us-ascii?Q?H8sTgeea8OkFN/ghDsRCyfTh7tY6gzg5mgfbEwzE+3vsq1NX3pdZ3WfE3oGn?=
 =?us-ascii?Q?0c7qPVzYi9bcrF/skCc8jON4sMY2b84c1xL8EvBihfGNqYgi2MZb17/xPf6C?=
 =?us-ascii?Q?6Q85pLw2eL44mrKWDxaAGDoA89D5WSKw6/r8ny65ob61KkuOGEwlVjNOV+UM?=
 =?us-ascii?Q?WeGAmLPc0mEJr3BMUUUqiWZtPELnTQ4WJy0tchWojebOOImbVBI1Q6LqbkCx?=
 =?us-ascii?Q?stlTzxXZs1dgqt5onTZvbSiymKe5OQbgSnf34drgRdIwudxxUQsFiuO17H9u?=
 =?us-ascii?Q?+3cQ6F9xBo0DAZrHVBMIJ4DzRcKXdp/OW/tLpZHVnMfenVMbwEMSEwy7Sckm?=
 =?us-ascii?Q?62Ah0XV+8RXyfAwPC2u1FXvOVZrpnM6pGWG7kxcms868AJTp8HIAA7GuuxJ5?=
 =?us-ascii?Q?VnnjZJxQ3tlsZjGjQ9msLBZ/VZFbPNoX9F1CiG6rTMVprQcK8hSV6nYMGAdc?=
 =?us-ascii?Q?41yUosZzyM62/BdpR9K3D1GMiyYx8lWEy7troPUMLJBw6l0/YzDLRQgcp9Rr?=
 =?us-ascii?Q?bOGiTXNjzaF+oObQCXFtcH6o2+2UCUhDQVkCKSu17ivf8a6GR+82hWQf18rC?=
 =?us-ascii?Q?gBTgb4uDwlg6af9VP9gAIn1MAHUoOT4L7M8CXpZoBU3CZzRYpx/LfKq+nS6k?=
 =?us-ascii?Q?q2evjQMPUA7+4IZ78Q2wvVSHfowLl/49x4UQyrOqPyXYDWoUkInGJXCktUFW?=
 =?us-ascii?Q?k0ZtsOCEkwypWEVlrXnQ4URsvrJ+xD3K8Ps2mtp7UJW2qH8t0ehsH6h+DDc1?=
 =?us-ascii?Q?+sLpdOSnbP88R7WTwKhusUxrI/rmCBtRrePSIb4Feygy1iNj0N4PHBqVuHYk?=
 =?us-ascii?Q?TMB4faHwmOsNdB5SJChk/vH1DfevAMJREk+FUsktSj4YLCdN8pbP3jP6V67R?=
 =?us-ascii?Q?QKYKchKv16Hzkf7jOkPdAfCi0NQyEW1R7uicDeXEZtqLbaP2TXQViBw29vne?=
 =?us-ascii?Q?Zju4RonfJ7Gpu75BkX+UxxyqFG0lc4/q1flzoxDCAfykwnnpemdhHzK321K1?=
 =?us-ascii?Q?WmeHO4cIGm+iBHkuI9CmF+E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YKbrFAaLGIG/HTeukfjRLIc49EaiepX5IBcYjVGxFMDa9ICbAJSwmHlRQ9s+MllqkSyU637F49Ct9lLCa5Z37afNS/gQyoucHnZRSac1dc9u1bP7zVQpneWvmYUrNF9pRKejaL5RF4KbH/gYBxRT0XWmsQyupl49vEk69M+2MgsUAyHWrMFj3yq/qk3kuopXgRLY5BaNl0CNIyoYtP963/waq/MVRr/7nutPOhj+Mpu4zs4UzgaBSYYYhoHfbdglRVoUQTWfiyYpbCxwRhIvsRuHgAKtL3NkWtC4fKD6baD1pdnnqgdexP81wez7iDneoxAB3YkfcZZ0byhpG23z86hAUspVEBIXb/6f4pS3TKpohmty2cIQOkztayP++26e7zUyIQhrF1RikTyeWHWHriuxHln9xO0f25meTMVnvZ3e7ncP/6rQfVkr2N+A1uC5MEk3UYrwhmYZI7miwpz4vP8Nym3daLIkVu01Ad2Pc15E60B86fb343LOZcq0BY7T4u9jiPnvL7p6PgzBdwv7F1FkceCc7Xv0xQa3Rli9SFUCHNysiO/gASHRRWQoJX+DfwwPf2CUK/luQG1A2CRxMVdY147ngj7UFuLdubV/TKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1b2a79-7cbc-4d59-d95c-08dc84bdb511
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:30.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28sTVdoYgGp2d/vQuPtCKDld9SvwYHE8tdslpLKVSP97AUI0DHhm0ynaD4WbXWfd+21Pm4tPlVSy4yJZYguJRz6/rxQoDnXnWqh2Qg/yg8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: auNnVvWluD28L6jy7NFku5XcrXrWOj0I
X-Proofpoint-ORIG-GUID: auNnVvWluD28L6jy7NFku5XcrXrWOj0I

Users of mas_store_prealloc() enter this function with nodes already
preallocated. This means the store type must be already set. We can then
remove the call to mas_wr_store_type() and initialize the write state to
continue the partial walk that was done when determining the store type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a90512d15549..eeb8def13f63 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4028,9 +4028,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
 	else
 		wr_mas->end_piv = wr_mas->mas->max;
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
 }
 
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
@@ -5595,12 +5592,23 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	if (mas->store_type == wr_store_root) {
+		mas_wr_prealloc_setup(&wr_mas);
+		goto store;
+	}
+
+	mas_wr_walk_descend(&wr_mas);
+	if (mas->store_type != wr_spanning_store) {
+		/* set wr_mas->content to current slot */
+		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
+		mas_wr_end_piv(&wr_mas);
+	}
+store:
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
+
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
 
-- 
2.45.1



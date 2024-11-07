Return-Path: <linux-kernel+bounces-399189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599949BFBFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F072832CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DC2940D;
	Thu,  7 Nov 2024 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="loJeocic"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AE219E0;
	Thu,  7 Nov 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944210; cv=fail; b=oT6VVp8iKjBGlcrMsAf08W3J7AfSnMJXaG+sDnL4AzOYX3yO6VGTvWB5ISw4hDAkqTWLUbk3DifY64hfq9hK597luT3etXmhWcuM0qhbWMPvDf0Gk1GuZynkFB7LFCK0C2otwcB3AL70C6bM5TA1GA/ZTzO+wj0QTJjykJRGe4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944210; c=relaxed/simple;
	bh=zbeFZcoK3TPnIG9is6LywWNr3hhPKGsng4weed42Nq8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lVCH4MIa0j6kLeSYzwkNt5xlGEUuT0HG0SdqYslfCpRPC4VGDGkdQLtRwe4Iucj3VaAkAadjmv5MpdVPrPXly+Z/ftEaaKNZ5dlrad4VcY/ueS7BPR2sG3Fh2me/3kiiDxOBjXH1SbbYmkLnJWs18k7IQu37NlcoAmleH1EnGy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=loJeocic; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A702Bhl003297;
	Thu, 7 Nov 2024 01:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=zR4Q5QL5WmImIY1jL8oDGN+dFQWJj
	pli4gqF2qVgzss=; b=loJeocicSrybOJm2KfEmtiLdAWUMb2Pf0PzuYmRHM2Oz8
	z6WnvblXiR/fla0siqLFVskCDSg5fiP7pK2klDMgU3MngHj5+6aW65vWzU7PvQ2I
	Dz9Zxb8svMopHy4bMiI49okvVvhplcY/wZE63hbfbns/jhcTns9WX5Bfag983Pjo
	XuAmZXsh+iSrlh0x4bjFEDvvdn1wpjx/eJRSYU958a6H5s5+xq3/wXcLU7BDsTyd
	JgKlGQIovZg2mAKhzmHXZw650yRplEfraNS75rNwwazCxX1ZI5ycw6h4zKkehny3
	TKwgsXFFdQxQkvcAx8v7k4k1IunA1w7IrNQCHWpHg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42r7fyrhyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 01:50:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raAsjdFH07lA47Qg1Gqz3wDoX8uBiCnXOMfLS7Gp+J76gRFi95Q59Xs0a/54ycf4epSgUPYJZ+/R9A4vHSeNCXnOBwW4kZeUctU8CcGUPYS6b6Q0RreCB5iY5855RRE4AuC+YUoJhOxRL984GE41aynkMZ/D5LFdFIXzGpRhBgQlGi9HvhnGQpdQFaWIwML+TlI/7ocUbkSvUJwqwbIdoX/LC0T1kl5Yq9wpZ2KVE/udEUkOkcgg5S4Gyq+DFLvj1xvoSlabhPwU2E5s+cTFG2jKH8sQvVueAMSxKNzEIuR7wlgY+yWBQpX8artIEppVTBimSBdHYMA0pyk3A6Y9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR4Q5QL5WmImIY1jL8oDGN+dFQWJjpli4gqF2qVgzss=;
 b=JDQmIxvuC6MWnPSKOE6R+LTsumHoDLaVyK3lm86B+C5xtFfTN6imCLcVzg/ZgVBPr/89n3m0VBXLJeZrGFHlo4Pzk/uZonV/jJSykY53Ug1a6fvmRKPOH//3TRpyEk8fsvZNUkBbwyUSGVNW4ommU6TsrhecjvCeHZbUblRUTpjefqV+wO2cFkNy87+rQRAggP4RbdOcmsnzVs1hMSbnwKsuly9U5nS2+5nxnyrRc1xypyhKB6vPVN3JxHvrjIOqr/k7FkIYktvnZmVDCIlrYtcBoqkO9rwRZNTo6JJu4Dii9Wg0H0+p1Mugbg3/BHmf1w6Mu29iej2cZPpU5C2nQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by PH7PR13MB5478.namprd13.prod.outlook.com (2603:10b6:510:130::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 01:49:58 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:49:58 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
        "edchong@redhat.com" <edchong@redhat.com>,
        Brian Masney <bmasney@redhat.com>, Eric Curtin <ecurtin@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [boot-time] Please check this wiki page about RCU expedited mode
Thread-Topic: [boot-time] Please check this wiki page about RCU expedited mode
Thread-Index: AdswtWFbGXP8/vd5RaqP/QfzD6mu0w==
Date: Thu, 7 Nov 2024 01:49:57 +0000
Message-ID:
 <MW5PR13MB563287E9DCEF5F43C0B2BB0AFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|PH7PR13MB5478:EE_
x-ms-office365-filtering-correlation-id: dc267f40-3c48-450d-8206-08dcfece7c2d
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?12IZlo3LMp0GmBD3zMIAJmypCef+Jl9ie8lW8l/WLaqZyppefCi3GTouYZrb?=
 =?us-ascii?Q?Ri+icvtVnn/3rnq4Pw+IilCs2XLLrX8cSqsbutPIf/tsptN+PlcGSkwrAWlE?=
 =?us-ascii?Q?e4wMvZBJsZZHla7VU0bLE3QGRp7f9XIT1xEftDTSeUrbYk3IAnP/VdssAehG?=
 =?us-ascii?Q?OLfhxScusaUi6MTpAi1ou0XQLa7J5peJIxg9Hib0GQCgckNmsL1DfDcilRua?=
 =?us-ascii?Q?1Qs0FykUTzMbe5QNXqaLcA1Tc1G2U1HMxR8j0uTIGkYyLK/MqFTBfurJXx3P?=
 =?us-ascii?Q?nZBzM3M5dvvy3L4JENQtWnm7j9PzPpI3kfq+UY85OGlA4hHCnplnKpUAb3zg?=
 =?us-ascii?Q?WGlh2T4dRJcJOgQgNdbrL2S7mUFqmfb5w0GWavMsmdEtb2jGPAl0LrtTi4D7?=
 =?us-ascii?Q?oUONynv/gBC81vffUpMz/bsLQ7DrPVo6QqMXu1P4ndOzbKradCpnLY5P1JAH?=
 =?us-ascii?Q?uUS28loUlLKO4FqM1pZ3Fp0ei5rP6OaVDgr6Jxa8zqamxsCYA64mRa2hMopP?=
 =?us-ascii?Q?8PIijTgPVmHchkws+BZd5lB6I7HRtVPPmsXvkGoKvuHb9vWF4NhqjfyuQxN5?=
 =?us-ascii?Q?kV+giKVwdrzKdQDEMiKrKUBFnFeLII+Vgf1+dJFOO2SnuQ4XdbvgbMTkUMeR?=
 =?us-ascii?Q?Br5sqbWtQkog3HIs5nme+7XWWe9Kkq6OFwAMXxCCWf5wlrkcGtJACFfOAxs9?=
 =?us-ascii?Q?VsXtv0VXzOjBoB8SH1WeJdZ+LEuwNPCpMxYp0P0Dk57067XLmvh+snAj1NEY?=
 =?us-ascii?Q?TgLCkMcGYoU58gIpAXKtjqMhhvuZd+vc7iHVED1+f44OSHBwOMb91n2Om2zF?=
 =?us-ascii?Q?A0nnFQzeVCZKtfBm+B/KSnBuXIv6Z35BYdMCz4SrZtP85BmlDV1Wz2/cuc4k?=
 =?us-ascii?Q?TJ6z9W8ZJV0NZMnEnI52o8BHJbD5+NTf1fZ2Ug+HHDjdf0NqtEF0BAdJxTsJ?=
 =?us-ascii?Q?1gDrcAzWgPC/6FCCxsTBJskkTnRCSDi49j7oc+YFbEtnFca6FF0Xl0RakRwD?=
 =?us-ascii?Q?weqyOrC/Ter0osjs0DOnMGHICDPuW4w5mecHxx0Lz0KKbxeytvwWf5RSV6Qd?=
 =?us-ascii?Q?9jK/5xiMrKfnp7ECrGpYrg5ixpTbYYXBaSQWjGXOK0Qatw59nqLLcu1ScJzY?=
 =?us-ascii?Q?tXhrp5xxOgBDf+WARo+RE0spvcSdxk2iUIQr5ckIxzGhD8NzNr3yv0CWtMVl?=
 =?us-ascii?Q?JuvKL8Be4FpCMSLmwmhEWFSMHLXIJPxiFi5X8Twqi0fAkZokfa02gdEoGMWO?=
 =?us-ascii?Q?1GQYxEksdOXNB1oHNmFpS7uOLJKiKIuyLN8qktLmwF3ifGQzo2EIbKKRfbO3?=
 =?us-ascii?Q?sgxiK5DSsMfHDK4bNdFPBHWV9rQxpvkwiNmN7dP7UUyO63UfcJHnVSKR24A4?=
 =?us-ascii?Q?VDzMHiYURVjvY4jFq7LRBE4tiDfD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kRPd7UKnWsgm2hNaB9oEja22TArInYU+GI8K0jV/yOVEQiI13A7ahQYB9Vai?=
 =?us-ascii?Q?Q3ogGn/aMaQD14e5vVuockT/ClZEfFkvE0SQJ02OrTaop4SWfZAGTBq9PIED?=
 =?us-ascii?Q?uC0lFFP6xtBSU+otcBCrZn5v2f2hw6vGKNCWqxiyGrhPym0RfzhOqxlf0G5T?=
 =?us-ascii?Q?nW5igKgzgcQ4aBJkmFf5Orti4Zuz6xmbsk1R3nE8h4LlGuBtnrWhKd3i+FEq?=
 =?us-ascii?Q?z/qgy51EICeNjFEtlxl+cIn/Bw3FaFHaz+SJvcOmvDc8Pc/LVABUpcQ8ti4w?=
 =?us-ascii?Q?GuyzHbQcy/PfKn0EoA+WM0MKQaFYQsNO+kUUFMEobz8AdkGBTiDchOz8VtPB?=
 =?us-ascii?Q?6GZTeOEYeKIc4gnBpeb1rzMvuUvmjvDHIz+cTZCqUqzLHx2f7dz01EnysXOe?=
 =?us-ascii?Q?/xYseom9RQclnCPgUfSZYHBI6tW6sH61iff4B9/HO2O+uY8dfombhZrbdHfa?=
 =?us-ascii?Q?+62ZBltKNDHEtm1MmT5DwEv4e5LyGxmgZBgAlOhhuFIQJsRrnSiaFMnI1Hn5?=
 =?us-ascii?Q?bSkuNuHch1frV7/g4fTPQWqKjeMWRT2/a/mcTJZOI11b2MEsPlsfx39IX2Nm?=
 =?us-ascii?Q?8E0BWDRsSGQzGeOscBhxWxmblHdTOA/FrIvX85+hq966RbouC/Rvdem+DSSt?=
 =?us-ascii?Q?oxjvgfyqj3jFHkRh8ikhv5geAytohWdv1xaRIasMlMBOEyqKLa6kV5rWvCBj?=
 =?us-ascii?Q?TW9VAZK3DJbwQoZSlLA7FlrgA4aqbQw1bc4gda/9YFDSQUHy3LR5S/3KGHXp?=
 =?us-ascii?Q?3HxszOF7K5po3AQqSWoRSg4ppUvGRf0MIjfMNf/eOg8jfT+JC28L5n7P+TAO?=
 =?us-ascii?Q?n1gWzn1d3ufaa3hIKP4ZSJg1fkPGzMGknEfBYcWuDQdbKuEZi/W8AITlJGoD?=
 =?us-ascii?Q?FH0CWfcfh42b1HY9gRPbyooPD/A+q8uaYHHc75xJuFTiqdO9RUMu4WRbUlGn?=
 =?us-ascii?Q?wNUwjpvAZYEJvYfopsC853sVq16uPkshqC+Ccm1uVpNHApoRWVKtR7czi8t+?=
 =?us-ascii?Q?SV/8lGo295GlPEg7JEnEroS+bEDgO/TccBLctwRoIk5YSEw4s3tOKiRv0bNX?=
 =?us-ascii?Q?vjmHh3oqMGQXTxSmJLFMwS8Nt6PCNeP/Te/y/F+/1qeePlWmeVv13xEfhaZb?=
 =?us-ascii?Q?pZLZzc69L9XL1HHPbwYAEG9n6+olaoYJ94rdAHU5lZKaHkdijl2jsiJuyayZ?=
 =?us-ascii?Q?6U3yQrHjKVgOA3T7+0y56nFx4Q1Ncuy0QNrSD2gCRTVHscsF2AewofSaLLRf?=
 =?us-ascii?Q?LCs7Ca8k4tA7uOESq6LV2zaL+bjYkxWA7z+bOw/phWkK7Z6kinIXHr+yOB0l?=
 =?us-ascii?Q?0WpIJclIuy2cMo2GIzg2iFsNlwXH2MaPuSiTrpNrs92h+4UbEc6ikopjo/It?=
 =?us-ascii?Q?naW5y2JnDHeMmwB6xZT2DYlmpUydJbgW75cHMEaVLrtKVD40HjHhlDW86U5U?=
 =?us-ascii?Q?T+gOLeIimBLlMjKgyNgBmpr8eXmITtFuA73IWtL5taSV2slS4CdDSdKeTZYF?=
 =?us-ascii?Q?HBJ1YfZ6a6y0FaFzNUdfiNLX9nAYoEKe5xPdzzkn2pwBjSnq/9vR1oSVjKhI?=
 =?us-ascii?Q?NttC47nLWXdq1lmzZDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CwU2MAH47jc4cIDX2MGikn267FB/DTW9Mwk+tQKk9f9mO93/ORoQym/dH0jiUojHseusJKsRV47wfGz8jBnE9IlZkY/CXYUqd13XGDV7wibrpS8fG8XGTHbDd/+7/XtAQKHYw28owmqhCg8yRnb7ojs+ly9CBtyjNTdWILKlp9SWn8cMEit2hkn6JFCZHEePN8k9YmnA+fAQSKU4mx3m7MuL5NUxe4RxYOJJVTUFtDdCpkrUHe2GDt5evT/zFO/43/VGCydcIxLULo6nWYqkvjHCTcYBIUE5QfhKpklizq5Iin96vl1HOc/Hs8fntc2eWPNfAR2mhrf3xH9GsnHsNHGpFUNrzEKGKpWZkpaE2szoZ07+e5x1yjjISd6kmhMmaOE0OzFfZB2HMorAINMeh+MJFzDusNNEiLzzwpJc71RwP1HdDHxxr5UiQoePMxhQHZSE5Y6PHxFQ6vSykv7mCuF6Quz0O4dzI+xAla+6D5DZ0YqHh0HuNDJJDZdFT/cUrQ6L3NZCSkkRY+pNgbdld5XSy6hUUVj7asgIYgDMbfSYkwdrsTi/2/n4cW5QwY1evzQLmCTzNPPaPED+Vfqr8wfF20zK932+KW37sp5dvyABiyqmIbRGl1fTiShl0v59
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc267f40-3c48-450d-8206-08dcfece7c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:49:57.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pG0fpfHpOk5UQ4f28j+k4DRRl9Vp/4bqJOGH9i888yoNIALSszEtfPZSGMYhVQhZvBX+14l+f+alNcMskV/kLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5478
X-Proofpoint-GUID: nKfRHb9z1q3U5pT25o7bRDIAU2ihsK-F
X-Proofpoint-ORIG-GUID: nKfRHb9z1q3U5pT25o7bRDIAU2ihsK-F
X-Sony-Outbound-GUID: nKfRHb9z1q3U5pT25o7bRDIAU2ihsK-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_20,2024-11-06_01,2024-09-30_01

Ed, Brian or Eric,

Can you please take a look at this wiki page, and correct=20
mistakes or add any material you think would be valuable.

https://elinux.org/RCU_expedited_mode

If you have a specific example of a boot time reduction
from using this technique, can you add it to the case
study listed at the bottom of the page.

I copied some material from your devconf.us presentation.

If you don't have elinux wiki accounts, you can just reply
to this email with suggestions, and I'll change or add the material myself.
One specific question I have is whether  this technique only applies
to an RT kernel or not.

IMHO we can collect information on various techniques on the wiki
(including data about their savings on different systems and in
different scenarios), and then migrate the material to an upstream
kernel tuning guide when we've establish the general utility
of the material.

As an aside question - if it would be easier to just review the material
on-list, let me know and I'll send the raw page (in mediawiki markup)
to the list for email-style review.

Thanks
 -- Tim



Return-Path: <linux-kernel+bounces-184663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A684C8CAA39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB4282413
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746E54762;
	Tue, 21 May 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d/i8zQCu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V8wJfwZs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEC134DE
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281179; cv=fail; b=PsoVNsVo44CuIwRSmSBhZo0jaDBVG8VoGVmkxGFR5G03Uve2/1sEX6H1AWd2ugRFHD6Fs4PrEaGmzoINJirj7GhjdXuhw2flXOqN/BnkghZXhG26a/Yq7Nd/8++1iJk7MC07/lAtwyYnN3qFYAJZx7s78OSCDDL0bWGJnkxeZXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281179; c=relaxed/simple;
	bh=ntKJFYCEmGAcjuN6orzBdQjYLngLXI28gyN8t16HFrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSMlzgC41CSp+ocwj+ucvfyn6+mIuCYYskhaelrfJqtK1SWSKWkM24NrIFY2/On9O2TiLE60HChEfsBN9YIzXpj42uBuyS9NfxUxjITR8Wihg771z3wbe4ZqnRGanpYVPZguvntP5g/2IkiukW6x+rnk5x6kr2lDsCIpwcuAJm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d/i8zQCu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=V8wJfwZs; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9295ad7e174e11ef8065b7b53f7091ad-20240521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ntKJFYCEmGAcjuN6orzBdQjYLngLXI28gyN8t16HFrU=;
	b=d/i8zQCuCxj42ZKG183TIhNTL4Uv1zo87dgU34sudUjRlZX0KpAA7LLXNIDoqGny2mra/SZ4OKNUOxsGUb0kk/owEUeunPLZncqCvgH5A1WCkpZMfi1PnhKKmGCOitl+QYkw5Jifk9qJlvt3EbVCV9otY0U8zFpryHmzdC3gaik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:64f1a98b-0aa7-4de9-9fef-78a535b729a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:b0391f84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9295ad7e174e11ef8065b7b53f7091ad-20240521
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2010475507; Tue, 21 May 2024 16:46:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 May 2024 16:46:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 May 2024 16:46:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9NgDjw6B+MKY9rvkBqgn/J6xErFJTe+NapITLqw+OuliLue6HfWjRx97Kiv8hIJZOzELACuKdGEmYjnRVjnlHzMnjySWPMjOxWxK+bK+ygCBkZmcovSdIAr5NHLhOcEJjqWNE3sncKWloWw6/aZLsMqVIk2t5ZHXzvbW4/XFhPcLy3F78t9HN/SMLZ+tdurAcktd57Km5d3EB6QJJjWdgsWqTjDiqIrf15kjnvTIclmKSa8zdFqiZo3mmo9ArlJ+/hVrZFTPqj+vPjcg6MwLewzu2pThxHoil4ykGbpiGT+4ni+ladgHdiYkzCPFaB/ygn71gpVqHQwWtX2J097aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntKJFYCEmGAcjuN6orzBdQjYLngLXI28gyN8t16HFrU=;
 b=JfX936WJbP5AFc28iptL+oP160VwgIjiyJsw+NMlf5S58VYRyD4PqQFdph3NQkagEZeVKfZcV5nj1Nv3Xh3HwWcDHK5I+om1codYiGz7i7Ok2/r19JWrPt+OBN7MODhkb2pXMh49llJdvTWYFXHQXSaRYWJ+lnMvI7aJRklxMXBRHaomywc5R5Q9js7JGkOQMpsr4jG0+GnGTyoDFdJPci70dCVkOJzYEeQaIzweljFJ6c1hdmmMqAltxzZmEdJ/sQooCnTS8o1rLP808zbqNI2MW19DZwe7N4LILU1zaGJiXKYN/9ArPgZVnrKl5IuN7OzVGzZdIx3iaY1oA54oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntKJFYCEmGAcjuN6orzBdQjYLngLXI28gyN8t16HFrU=;
 b=V8wJfwZsN5KUMaO4EhAbthRsv7FY/I3Z4kzJI0qpDC6/gdrx45IAcTope0L/LImLQAxnnPl0cxXpSMuIHRdlWtrDrgZMBIM3PEl082GiJ2R+0x8pobvX3U4Gobd0eL2rbVxcm6TA/oepjD2jWOPBPxz3LuavvrTj83NcCmZ2i4w=
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com (2603:1096:405:95::8)
 by SEYPR03MB7269.apcprd03.prod.outlook.com (2603:1096:101:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Tue, 21 May
 2024 08:45:58 +0000
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::e676:6dea:a250:27ed]) by TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::e676:6dea:a250:27ed%4]) with mapi id 15.20.7611.013; Tue, 21 May 2024
 08:45:58 +0000
From: =?utf-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
To: "sumit.garg@linaro.org" <sumit.garg@linaro.org>
CC: "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
Thread-Topic: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
Thread-Index: AQHaoCJhsF0P7EeR+E65Y73ceegJV7GgBaoAgAFwqYA=
Date: Tue, 21 May 2024 08:45:57 +0000
Message-ID: <929512b561536d4ddfaeda518f2ce306b899f3a9.camel@mediatek.com>
References: <20240507020037.14009-1-gavin.liu@mediatek.com>
	 <CAFA6WYN79E8Hyxsaxu20hkyNebMqBWV7az5ByekTuii7Y7qjng@mail.gmail.com>
In-Reply-To: <CAFA6WYN79E8Hyxsaxu20hkyNebMqBWV7az5ByekTuii7Y7qjng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8836:EE_|SEYPR03MB7269:EE_
x-ms-office365-filtering-correlation-id: cb0244ce-4b99-44f0-ec31-08dc79726f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VEY4RkdOWThxd3RZQTcydTVMWVRhZ05CY2hrS3pHek1LVWozQjJidjF6MVh1?=
 =?utf-8?B?dFFwZTgxNWhycGtsNndVVEcxYU1hK2Vodk9NOUJZOHVHVk44M3BGMDNvbGxH?=
 =?utf-8?B?WGFSM3FyVzMxV3oyZ09nZHkyYW1hMDJFbkdBZElmODA3VE5hczRwa24wc082?=
 =?utf-8?B?REdibVdHU0wvSmFlSDlLcGxlMEx1Y3BRSUZjL1ZDcFIxd1ViU1hBMWwzbTZ3?=
 =?utf-8?B?SzRVaVd0am80Rk5UMTFBQ0ZIZXFxK051OWh6UHZnUTVyMlBGOXFCbjNFT21p?=
 =?utf-8?B?VW81QVM3MWYzazZ1eStoN3pubUtHYWlld0JmeEozcWZQWmw1ZnJaM01VSWN2?=
 =?utf-8?B?V0FtazBoNERYSVJwc01SSE84cHJTM0dDYWE3dC9KTjhreWpLRy8vZ05VWEwz?=
 =?utf-8?B?UDdkRlkyaUZOUHZIN2tacDNFcHRDMnRKQ2s5eUlDMGIzVlVHelY0NDF4ZXdN?=
 =?utf-8?B?NS94Y0JBL0JyRVRFdDJLKzZTNC9CR21Oc0lSMGp3OG5WRnJ2dXFSbGNRT2Fs?=
 =?utf-8?B?RUlkc2hpS1pCM1lMdXZFdklITDZ5TVMxME5mK0FlK1JWek5xVzJhKzNiS04r?=
 =?utf-8?B?ZHBoalZhTVlRMm9xbExCTXp5VG9NRlFsK25CemtsN3JMNjRJSExnVjd0Rlll?=
 =?utf-8?B?RFV0blFHaWNPMWc2ZHhnM3prNThuZE5zOEtadnJjMUNKbU9KU1ZkY296T25P?=
 =?utf-8?B?T2h4ejd6OFVrZzF5Y25nZ1g2Q0ZhbU9TVnRIeFc0UlIzZDZES0Nzb3BkRU9x?=
 =?utf-8?B?RGgrWTY0RkcvRVpyZkUveG9yRkJNdnJtWUVDWE4zclE0WmlaRk83V2hzVFdS?=
 =?utf-8?B?dkl3SHVuVTV0NTNpUjFpQ2dMVDE3OStwcHkrbTVINDdzOTlMTCtoZE54dUlP?=
 =?utf-8?B?dGJiUG84U0p3V1J5Nlh2czhjSFVFbnE1TlVQd0orN0lzTVpheXRnOWtadG9B?=
 =?utf-8?B?RWExN1JqK0JNYUY0RFFwcnZCb3NtckFoclpWdkQ5ZHh4NWQxRFE5Wm9IckNm?=
 =?utf-8?B?NjdicFJlQnRQd0FHRXhYQ2ZrYXg1eE9uTytEVEE3UnRRZ0w1UUE5akF2TWJS?=
 =?utf-8?B?NWxTNm12eWQ1dldHZjFnN0gxZlNXUnlTMy9qRkFOM3Bqalg5SmtGdkJDeG9I?=
 =?utf-8?B?ZnZVOWdFQmZDcGtzQ0M1VnRnSnBUbmg4UXM4RmQ4TGpsdTVJU0RCOE1EVERQ?=
 =?utf-8?B?WGpNaWxobnNWTWp6a2M0eUkwMi8zWjVaT3JZTGY1VkRuQWhwY0JJSGZwUVIx?=
 =?utf-8?B?ekNqT2pVVlhNRlZPbFkvanJlL0VMUGZYekZkNVMwVEZrR0FmWkpsY200Slc0?=
 =?utf-8?B?OHZ1V0NTVSt2RDl2Z2o3dVVOZ1ZmNnpHVEpBaXFOK2RRREZxY0oyWlllYXkw?=
 =?utf-8?B?RXdWRDBsODRnUzVBSnVIZkxiWCs2U2hiUzloT1ZZaWlyTVBoMjByNGxLRERt?=
 =?utf-8?B?TkFnY21CUDIrWHE4QVFtSlpVR3JlOWZMVm9IdFJrQmlRclVrZWNnREVjam9O?=
 =?utf-8?B?M2hZOGVLOE5sVWdmWWd6eWRFanVKVDUvejlxTk5XM1RlQVdvNzdUdmdlcm5t?=
 =?utf-8?B?K3A5OEpVQ3E4b0ZIQWpaQUNWMXlWek9vdDdaWmo4SlFiazFUNWlBRlBJTnQ3?=
 =?utf-8?B?Mzk3ai9CUFZGL0ZLRjBIWTFHNzFmaS90TjlSanhqRmlUOWFOekI4eEpMbXln?=
 =?utf-8?B?a2JZUXdoZ1ozZU1LU2RHTVdCL2ZWZE9IeWxkSGVQN2FLdVdDYlBJdk5BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8836.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW1NcjhNRVZPSUM1ZHZUNVJSZGQ2aHJjT0VYQzB2elBYeW5FdjdROStaQ0la?=
 =?utf-8?B?b0JSZDBmMDdPTzBPUHIySXJWYmtHSHlBT1E3L25MYTRKd1J6NUY1TzltZGpi?=
 =?utf-8?B?Mno0aVRpZllBdjMrVURYOUtQSjdGMkZmVjF5bjYwVzhhMkp0VXB0UGU4OU9P?=
 =?utf-8?B?U1picVoxMVlwdWVzLzM1b1dMZWk4a1ZqbCtwOW5CNld2Q1FGQ3VPUE9hRkFx?=
 =?utf-8?B?YlpWbU9KZEdjdHNkbHJOL2ROZXdhT0hBV0JMWXJnaDFkSnliWGhIRHEwRTY1?=
 =?utf-8?B?eU5obTF1UXFEUjdLWk1zY2RPeWppWUZVcG15YUN4T09wNlp3L00wOXplV08y?=
 =?utf-8?B?c1BuWTRwaXJHaVFwcjl4Q0ZJT3dzSXN6SHgyYjB0QU1EVytNREV5OHNsUWl0?=
 =?utf-8?B?Y3BGSDF6RktrdElGeGVmdUZEYi9qczM0RXRoM053bEFWRUpTNDRtUlhJVkUx?=
 =?utf-8?B?Z2VZNEd3UlZKQnVpdlBvYWFWT0pHMmlLZmZjUzFlWWw2RU0xZHZGSjdxdHpB?=
 =?utf-8?B?M0Uybk9FdUI2RlNVMGVTMjRMQUZreVR2b1dxdFd1L2w2TXhiWENzT3haUmRT?=
 =?utf-8?B?c0JEbktKYU9HOWN2b1NnSVhoZERpemU0ZTVwaFhVaUkvWEVseVFmSXlFbGo3?=
 =?utf-8?B?QVFUWjRxSlZOVlhva2xQQUxVVWJvNHlZMzR6eFBUanY1S1lpcGIzVXY3WnV0?=
 =?utf-8?B?czNLZkt3YWRKSHBkc3RxbTFrOGhTNEVqQnU1U000TXVvVFY0Q1dZemVNMTRM?=
 =?utf-8?B?dHZNa3Q1NVhMckdSU0V0aVBBOUkxS3NPNnZ2dzI0enpLeDdFTUUwcW5ydzN1?=
 =?utf-8?B?TWpPVmluenlsOWw5VWZNYTBhUWdPRTU0OVdJTlpTazVSOXgzalJ0TUFpNmZq?=
 =?utf-8?B?dzNGaUgzNUI5V3pFUGNJWmtxRTY5MUExSXRsbEhobDJLV0hqSXEwS3hVYkJ5?=
 =?utf-8?B?Ky9EWTBmVU0vMkFZQzdCb3huSFNIS3dOTU1lUE5MZENFTXhGRFRzbU44eDBh?=
 =?utf-8?B?bkR1c0FHSXdrNk5WRjlGYTVuR0NvNXovaDg0cVhMN1d0Z2o0cFlPc3FCc0VS?=
 =?utf-8?B?ZmdHR296bkVUNGhTcEVnSlJuMzRqRkk2b2F3ODR1Y21tOEFRY0FBRWVtcGt5?=
 =?utf-8?B?TW5jZ1AycDdYRkthd1UrSVIrUEJMSklXbWxCSmRNYXo1a1RhbGVDeEF0NGxq?=
 =?utf-8?B?ZXZVRVgzbWg5VkFSU0szK0tlWmVzR3lGTlI2SnYvYXJxcUd1ZmlKbVZsN2hO?=
 =?utf-8?B?VFNDelpqK1BTTlcwYXB0VHZzUjEvRU0xQWRaNVR2UzJ5eno4UDJ0S001Nno0?=
 =?utf-8?B?dnVZdFI0aHhZclp2VEM2dzdLQjUwd21POUwrbVZXUlVVbGpTYzhjVEVnSHVr?=
 =?utf-8?B?Nll3QzRhVk13QkkveFg2Q3hvUGxKVUUyd3hrQjFKQlA1VGtvUndGQXYwLzhj?=
 =?utf-8?B?ME1qeHhkT00zN1BJRzN6elEwRW9FSkJMYnBLckRDM2xJcElSN2dPSFp2SlRG?=
 =?utf-8?B?OUxMdTdIUjJsZ2FuUVlGWnhlcFNKT1gva295YUVNUXpFNzRUa0s3d1FxK0ZK?=
 =?utf-8?B?LzNkOHdxN2w1WVk1anp5amk0K29hMzJCYUhuRDVNMFRrUWVsaTV5LzY0SGw2?=
 =?utf-8?B?bDZCSWtaWkpsNjVFUTVkRGtiellna0tPSGRMREpDTkZoZW1McTlYSjFKanlm?=
 =?utf-8?B?NEEzbk5ZUVRJQzdMdUdRTXdINGhaemVUMGFIMld6RFRRT2NEdzFHMlZ6K1BO?=
 =?utf-8?B?MVl3Q3dsTUtFVzZjTWlOemttellPNVcwTzZjYWtvMlpid29LS2VjMVRBcCtk?=
 =?utf-8?B?OW5Oejc4TEZEdlRycyszb3dDY0dIMzc4UlA5MjdjMFR2RTVZVkIraEVubmpu?=
 =?utf-8?B?c0RVV3FjU3NiSFdiUE1NWFJDaWxydGRDekxLdFR1VTNGVGhBZ252QVZSSXZZ?=
 =?utf-8?B?WHdpNkdwL0JWSUhreHQwU05sZjVkRjJSb0VkOW5CTFRveEZDWEtKTTJ0Wk1i?=
 =?utf-8?B?MTl2RXdEWU40TnEzcnFZTHkweC9Da3EydzRNTzF2TlFkWWt6dUh2WVE3VFFh?=
 =?utf-8?B?VUpsRGlXeTdNbTFYSUh0ZVN5MmxVa1Y0dHhrbjhCZkwvbnN2YnlMSXA1QmJM?=
 =?utf-8?B?bWtuakJHclNHUDdwM2NWZUhNY01vVG9XZ1BIOU5KZVVaSFVydXlFVVNvSWo4?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <238DB275FA28584E8CCF4B3AD74107D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8836.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0244ce-4b99-44f0-ec31-08dc79726f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:45:57.9071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSoFMv5fov/tmHyEoslcW1EWjYHm1qZAYXwMG3hM6NZocSVz2402Vcr9c8NYvhnSFRGBHSn2aUdFASSqzb7g2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7269
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--31.202400-8.000000
X-TMASE-MatchedRID: Nail4dlEBNHUL3YCMmnG4omfV7NNMGm+RWISSV5hxi/IvQIyugvKdTpf
	D8bzJt2+IUM+EI7fOGPNgz7AfzbtbqTQXj+P7SBG8eSmTJSmEv2Z43ybYV0aJzfE7ZHdugFYVu6
	ohj7+yRCQAE+AoG3/Shi2uhEXd1n+dghCgcSLH6pc/msUC5wFQSseSAhqf1rRNSweOixQAJLSLv
	4Q3aNAfy866wZroIXH/+hYgMilDtQdWKRD1iYss+KXavbHY/C1RvyVHewb0kK/wPtA9baOj+v5b
	bQ5DwzeL1QOIxwYqKiotpJeaBt/5tUW1/ttV+ezDB+ErBr0bAOuiRuR9mCauhBVEcLcHoVggSkl
	Fxt6Wp33cuxjGnQlwJGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--31.202400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0899C448DC4702567BBAC55E891CBB97773F449DC0138354CA63F7A1DB3E23F62000:8

SGksIFN1bWl0LA0KDQpUaGUgY29ycmVzcG9uZGluZyBPUFRFRS1PUyBwdWxsIHJlcXVlc3QgYW5k
IGNoYW5nZSBpcyBoZXJlLg0KDQpodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL3B1
bGwvNjY0MQ0KDQpPbiBNb24sIDIwMjQtMDUtMjAgYXQgMTY6MTYgKzA1MzAsIFN1bWl0IEdhcmcg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSGksDQo+IA0KPiBPbiBUdWUsIDcgTWF5IDIwMjQgYXQg
MDc6MzEsIGdhdmluLmxpdSA8Z2F2aW4ubGl1QG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBHYXZpbiBMaXUgPGdhdmluLmxpdUBtZWRpYXRlay5jb20+DQo+ID4NCj4gPiBB
ZGQgdGltZW91dCB2YWx1ZSB0byBzdXBwb3J0IHNlbGYgd2FraW5nIHdoZW4gdGltZW91dCB0byBh
dm9pZA0KPiB3YWl0aW5nDQo+ID4gaW5kZWZpbml0ZWx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogR2F2aW4gTGl1IDxnYXZpbi5saXVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5n
ZSBpbiB2MzoNCj4gPiAxLiBjaGFuZ2UgdGhlIGNvbW1lbnQgaW4gb3B0ZWVfcnBjX2NtZC5oDQo+
ID4gMi4gYWRkIG1hY3JvIGZvciAiVEVFX0VSUk9SX1RJTUVPVVQiDQo+ID4gMy4gY2hhbmdlIGZy
b20gIlRFRUNfRVJST1JfQlVTWSIgdG8gIlRFRV9FUlJPUl9USU1FT1VUIg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5jICAgICAgICAgfCAgOSArKysrKysrLS0NCj4gPiAg
ZHJpdmVycy90ZWUvb3B0ZWUvb3B0ZWVfcHJpdmF0ZS5oIHwgIDUgKysrKy0NCj4gPiAgZHJpdmVy
cy90ZWUvb3B0ZWUvb3B0ZWVfcnBjX2NtZC5oIHwgIDEgKw0KPiA+ICBkcml2ZXJzL3RlZS9vcHRl
ZS9ycGMuYyAgICAgICAgICAgfCAxMCArKysrKysrKy0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gQWx0aG91Z2ggdGhl
IGNoYW5nZSBsb29rcyByZWFzb25hYmxlIHRvIG1lLCBjYW4geW91IHBvaW50IG1lIHRvDQo+IGNv
cnJlc3BvbmRpbmcgT1AtVEVFIE9TIGNoYW5nZXMgdG8gYmUgc3VyZSB0aGF0IEFCSSBjb21wYXRp
YmlsaXR5IGlzDQo+IG1haW50YWluZWQ/DQo+IA0KPiAtU3VtaXQNCj4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdGVlL29wdGVlL25vdGlmLmMgYi9kcml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5j
DQo+ID4gaW5kZXggMGQ3ODc4ZTc3MGNkLi4xOTcwODgwYzc5NmYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy90ZWUvb3B0ZWUvbm90aWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL25v
dGlmLmMNCj4gPiBAQCAtMjksNyArMjksNyBAQCBzdGF0aWMgYm9vbCBoYXZlX2tleShzdHJ1Y3Qg
b3B0ZWUgKm9wdGVlLCB1X2ludA0KPiBrZXkpDQo+ID4gICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ID4gIH0NCj4gPg0KPiA+IC1pbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVl
LCB1X2ludCBrZXkpDQo+ID4gK2ludCBvcHRlZV9ub3RpZl93YWl0KHN0cnVjdCBvcHRlZSAqb3B0
ZWUsIHVfaW50IGtleSwgdTMyIHRpbWVvdXQpDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ID4gICAgICAgICBzdHJ1Y3Qgbm90aWZfZW50cnkgKmVudHJ5Ow0KPiA+
IEBAIC03MCw3ICs3MCwxMiBAQCBpbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9w
dGVlLCB1X2ludA0KPiBrZXkpDQo+ID4gICAgICAgICAgKiBVbmxvY2sgdGVtcG9yYXJpbHkgYW5k
IHdhaXQgZm9yIGNvbXBsZXRpb24uDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAgICAgIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJm9wdGVlLT5ub3RpZi5sb2NrLCBmbGFncyk7DQo+ID4gLSAgICAg
ICB3YWl0X2Zvcl9jb21wbGV0aW9uKCZlbnRyeS0+Yyk7DQo+ID4gKyAgICAgICBpZiAodGltZW91
dCAhPSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghd2FpdF9mb3JfY29tcGxldGlvbl90
aW1lb3V0KCZlbnRyeS0+YywNCj4gdGltZW91dCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmMgPSAtRVRJTUVET1VUOw0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAg
ICAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmZW50cnktPmMpOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJm9wdGVlLT5ub3RpZi5sb2NrLCBmbGFncyk7DQo+
ID4NCj4gPiAgICAgICAgIGxpc3RfZGVsKCZlbnRyeS0+bGluayk7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiBiL2RyaXZlcnMvdGVlL29wdGVl
L29wdGVlX3ByaXZhdGUuaA0KPiA+IGluZGV4IDQyOWNjMjBiZTVjYy4uNDI0ODk4Y2RjNGU5IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiA+ICsr
KyBiL2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiA+IEBAIC0yNiw2ICsyNiw5
IEBADQo+ID4gICNkZWZpbmUgVEVFQ19FUlJPUl9CVVNZICAgICAgICAgICAgICAgICAgICAgICAg
MHhGRkZGMDAwRA0KPiA+ICAjZGVmaW5lIFRFRUNfRVJST1JfU0hPUlRfQlVGRkVSICAgICAgICAg
ICAgICAgIDB4RkZGRjAwMTANCj4gPg0KPiA+ICsvKiBBUEkgUmV0dXJuIENvZGVzIGFyZSBmcm9t
IHRoZSBHUCBURUUgSW50ZXJuYWwgQ29yZSBBUEkNCj4gU3BlY2lmaWNhdGlvbiAqLw0KPiA+ICsj
ZGVmaW5lIFRFRV9FUlJPUl9USU1FT1VUICAgICAgICAgICAgICAweEZGRkYzMDAxDQo+ID4gKw0K
PiA+ICAjZGVmaW5lIFRFRUNfT1JJR0lOX0NPTU1TICAgICAgICAgICAgICAweDAwMDAwMDAyDQo+
ID4NCj4gPiAgLyoNCj4gPiBAQCAtMjUyLDcgKzI1NSw3IEBAIHN0cnVjdCBvcHRlZV9jYWxsX2N0
eCB7DQo+ID4NCj4gPiAgaW50IG9wdGVlX25vdGlmX2luaXQoc3RydWN0IG9wdGVlICpvcHRlZSwg
dV9pbnQgbWF4X2tleSk7DQo+ID4gIHZvaWQgb3B0ZWVfbm90aWZfdW5pbml0KHN0cnVjdCBvcHRl
ZSAqb3B0ZWUpOw0KPiA+IC1pbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVl
LCB1X2ludCBrZXkpOw0KPiA+ICtpbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9w
dGVlLCB1X2ludCBrZXksIHUzMiB0aW1lb3V0KTsNCj4gPiAgaW50IG9wdGVlX25vdGlmX3NlbmQo
c3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQga2V5KTsNCj4gPg0KPiA+ICB1MzIgb3B0ZWVfc3Vw
cF90aHJkX3JlcShzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgdTMyIGZ1bmMsIHNpemVfdA0KPiBu
dW1fcGFyYW1zLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycGNf
Y21kLmgNCj4gYi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycGNfY21kLmgNCj4gPiBpbmRleCBm
M2YwNmUwOTk0YTcuLjQ1NzY3NTFiNDkwYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RlZS9v
cHRlZS9vcHRlZV9ycGNfY21kLmgNCj4gPiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9y
cGNfY21kLmgNCj4gPiBAQCAtNDEsNiArNDEsNyBAQA0KPiA+ICAgKiBXYWl0aW5nIG9uIG5vdGlm
aWNhdGlvbg0KPiA+ICAgKiBbaW5dICAgIHZhbHVlWzBdLmEgICAgICBPUFRFRV9SUENfTk9USUZJ
Q0FUSU9OX1dBSVQNCj4gPiAgICogW2luXSAgICB2YWx1ZVswXS5iICAgICAgbm90aWZpY2F0aW9u
IHZhbHVlDQo+ID4gKyAqIFtpbl0gICAgdmFsdWVbMF0uYyAgICAgIHRpbWVvdXQgaW4gbWlsbGlz
ZWNvbmRzIG9yIDAgaWYgbm8NCj4gdGltZW91dA0KPiA+ICAgKg0KPiA+ICAgKiBTZW5kaW5nIGEg
c3luY2hyb25vdXMgbm90aWZpY2F0aW9uDQo+ID4gICAqIFtpbl0gICAgdmFsdWVbMF0uYSAgICAg
IE9QVEVFX1JQQ19OT1RJRklDQVRJT05fU0VORA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Rl
ZS9vcHRlZS9ycGMuYyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gaW5kZXggZjA4Njgx
MmYxMTc5Li41ZGU0NTA0NjY1YmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90ZWUvb3B0ZWUv
cnBjLmMNCj4gPiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9ycGMuYw0KPiA+IEBAIC0xMzAsNiAr
MTMwLDggQEAgc3RhdGljIHZvaWQNCj4gaGFuZGxlX3JwY19mdW5jX2NtZF9pMmNfdHJhbnNmZXIo
c3RydWN0IHRlZV9jb250ZXh0ICpjdHgsDQo+ID4gIHN0YXRpYyB2b2lkIGhhbmRsZV9ycGNfZnVu
Y19jbWRfd3Eoc3RydWN0IG9wdGVlICpvcHRlZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBvcHRlZV9tc2dfYXJnICphcmcpDQo+ID4gIHsNCj4gPiArICAg
ICAgIGludCByYyA9IDA7DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKGFyZy0+bnVtX3BhcmFtcyAh
PSAxKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGJhZDsNCj4gPg0KPiA+IEBAIC0xMzksNyAr
MTQxLDggQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3Qgb3B0ZWUN
Cj4gKm9wdGVlLA0KPiA+DQo+ID4gICAgICAgICBzd2l0Y2ggKGFyZy0+cGFyYW1zWzBdLnUudmFs
dWUuYSkgew0KPiA+ICAgICAgICAgY2FzZSBPUFRFRV9SUENfTk9USUZJQ0FUSU9OX1dBSVQ6DQo+
ID4gLSAgICAgICAgICAgICAgIGlmIChvcHRlZV9ub3RpZl93YWl0KG9wdGVlLCBhcmctDQo+ID5w
YXJhbXNbMF0udS52YWx1ZS5iKSkNCj4gPiArICAgICAgICAgICAgICAgcmMgPSBvcHRlZV9ub3Rp
Zl93YWl0KG9wdGVlLCBhcmctDQo+ID5wYXJhbXNbMF0udS52YWx1ZS5iLCBhcmctPnBhcmFtc1sw
XS51LnZhbHVlLmMpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmMpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBiYWQ7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ICAgICAgICAgY2FzZSBPUFRFRV9SUENfTk9USUZJQ0FUSU9OX1NFTkQ6DQo+ID4gQEAgLTE1Myw3
ICsxNTYsMTAgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3QNCj4g
b3B0ZWUgKm9wdGVlLA0KPiA+ICAgICAgICAgYXJnLT5yZXQgPSBURUVDX1NVQ0NFU1M7DQo+ID4g
ICAgICAgICByZXR1cm47DQo+ID4gIGJhZDoNCj4gPiAtICAgICAgIGFyZy0+cmV0ID0gVEVFQ19F
UlJPUl9CQURfUEFSQU1FVEVSUzsNCj4gPiArICAgICAgIGlmIChyYyA9PSAtRVRJTUVET1VUKQ0K
PiA+ICsgICAgICAgICAgICAgICBhcmctPnJldCA9IFRFRV9FUlJPUl9USU1FT1VUOw0KPiA+ICsg
ICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBhcmctPnJldCA9IFRFRUNfRVJST1JfQkFE
X1BBUkFNRVRFUlM7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBoYW5kbGVfcnBjX2Z1
bmNfY21kX3dhaXQoc3RydWN0IG9wdGVlX21zZ19hcmcgKmFyZykNCj4gPiAtLQ0KPiA+IDIuMTgu
MA0KDQpSZWdhcmRzLA0KR2F2aW4gTGl1DQo+ID4NCg==


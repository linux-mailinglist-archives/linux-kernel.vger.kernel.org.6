Return-Path: <linux-kernel+bounces-397326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3639BDA81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94581F23F87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BF558BC;
	Wed,  6 Nov 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="iW/VtED8"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451F17D2;
	Wed,  6 Nov 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853960; cv=fail; b=OaLEVLnT1UsYXraQRe6D7aRoQQ4nZrF24lwOn+JubQI0cAi0s4b1jKqQORhWUBlyJ6JmZ00ZzraiYTmeYo9wGMlaXHqhFkSd+yCSVYo/AZzo+dfcbEfeR/H7MmdsAAkFyDopxQl4ZkB+qNtcRbw0oYi9Qe+ee0FjDSV0t+Fehzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853960; c=relaxed/simple;
	bh=Icxj715rIJcXm+xkgm+/yZDPWucs8eapJYrudVnYPIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=k+Zrdwgp6n2qvZq3dVIzMsA6UfiykZh3lOSJYac45PL9RY07b/ucoO3AJU5Jua+A268D748cQZfy4QGkJl5R/P2IH+wL3tA1UiyzTPsYnu7tWFWuhtv7ZDxLOtfnVlC7AuUhERHy3IzKrgNu0Gdv72q5XDm3wo/570mhOOE2piE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=iW/VtED8; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5NAv9G006414;
	Wed, 6 Nov 2024 00:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=rKMN5qJ
	on1oYS1a/VfEyKq6fib/Saish7odwaUnDzvk=; b=iW/VtED8IbOnG5DtklQ3ewQ
	LRooOIzXdE1Yma1riFgMGg3q8Ao3gwTVPcHg8ATaa2GAQCLt295XR+AjPYDzGo4y
	VtBzNb0kZroDAlWhCvT5y/9gS1upGAC6rNI9CMJ2G4k0eNUg0Pm40Na6xeLiW4Ty
	h5Iciye1dX3UNp8okwlQSmUR64MszRDKktNT03lCeSc9DSUuyW9eLjUpsuWKf3yV
	kyEDclWotFm3a372RqIEBhvVtgOcrM0r2Fd7qOVkb7qJeeoRk152eTFNTCIHjvmc
	aN5oSGW/VDYFK+faGqiD3SreTGP2luYpKfE33NPeuMKYn7sqzNVPyt9YBN4IBng=
	=
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42ncfnay2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 00:45:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHg5G08GtRkBW2FolTK5AIefPevFTn5C/7SPdjNAES+XUfa+TkOtTqBA+1uCj2iBDmUMD3EFQlYBJ1LdhBah6G7Q0SQu8P3xXy52v/dpznT/JXTICNZCdylmsMa0qIdR/p+Xd0ih7RzgKZFuTuLYwxV5gzhMmd60DgLncM1tiu3nIHn1ZBZOydbT2s42GKx4CBbYSHBl2WSAttYE8z9DUne+xcuMWaE3blBHXs4GX5cvAUpXS4vgsAQ+JDxW7liBF2+wp4/y9Zh43IRY15kVwZoMgDQcIP+3eQUSRwuMZrNYu0vQb4LvfyHQ1DWQM4KKhVbVRmhcvAB6KY3yICCtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sfd7rjo1ciq7kvnNdwW5HigVfX6j4YxIECYIyT2Zqg=;
 b=L8MG7KJ85s08LVJN5TsSCdku4plP41fMBGwREDO+IukpZvFVn9U3K1rZMlcnuNJCMfFsbVc8eXGDcjOSGk40d2xjTRXO7J3JfLTSkdkt+tDWEiHkUxCB4wKDmhJWmHvCxxtwz9KUdF7LUIqSWbeM7rDf0NI6/Xa8AlJzw4KKJq1A8HqTVU9xzMFpQocWiOR+06OyNJo/npUV64IQDcV7ze4sv91Nh2pQuRClw4LOjqst8DIxIx8o+qZa4kVKKOfpRgjV2nx1Q3cBZdjrt/Ejn5fcwPkp6LIcjhG2d2sEuqeVnv1WwkC3dnM4ajwHghvyNsKcpDPNQNWdTAE6IqG/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by MWHPR13MB7060.namprd13.prod.outlook.com (2603:10b6:303:288::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 00:45:46 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 00:45:45 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Brian Masney <bmasney@redhat.com>, Saravana Kannan <saravanak@google.com>
CC: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Boot-time initiative (SIG) thoughts and next steps
Thread-Topic: Boot-time initiative (SIG) thoughts and next steps
Thread-Index: AdsnCeBneydgAwbrQsOuFQyqBOu5BAAb/amAAFavyuAALTTAgAGVsygAAADjN9A=
Date: Wed, 6 Nov 2024 00:45:45 +0000
Message-ID:
 <MW5PR13MB5632276F33CCE4E18D0258E0FD532@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
 <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
 <Zyqz1LBDXZosrjle@x1>
In-Reply-To: <Zyqz1LBDXZosrjle@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|MWHPR13MB7060:EE_
x-ms-office365-filtering-correlation-id: c4ade4e5-4a5b-4e20-6f84-08dcfdfc59b9
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmN0WDduMWw2U1AvN3owWW9vMHJ2Y2JBTjRNam9ZdStBZjdyNDJXV0VxVU1y?=
 =?utf-8?B?dG5ES2liM2xxSEQwSEVENEE0OTB4QVhnWnhyVUtGUlV6SnVXNlJVT2Z6SUwv?=
 =?utf-8?B?Y0dQdHhsQmRFNFp5QzI3NExtRFZnN1UxUWdxNWtJN0VqSE1IaWwvOUdFaXFl?=
 =?utf-8?B?aVIwM1F3dEd0RHozaHhGMHpob1M2My9mSEFDeVI0eUR2Skwyd3hvSE1jWHZo?=
 =?utf-8?B?RlJLaUJ6d1dYYms5QitiVmphRC92cXcwcDJoZFVaVDV3a0xBYkpVUDlDZkgr?=
 =?utf-8?B?dkR2OUlUc045QXBYbzZoZVVEK1B6YTFIVGlDSzZMY2FqcW13Mk0zTHl4cVhF?=
 =?utf-8?B?U01pR2lPSWo0Vjh0dzNxYzlnbkM0eVRheFh0UHd3RExjbm5rMVZINmR5VC9m?=
 =?utf-8?B?bXhCeGM4ejNPU1lIV1A1dW8rQVJqVG5BcDFNMWVocWladDZVWDltcWd6cUY4?=
 =?utf-8?B?emFORG1DS0gxWnJkcllYOFF3eGtPcXg4VjNqUEFnSlZSbndlYU1JNjBJK3BC?=
 =?utf-8?B?TUx6ZVNVMFlHdVFhSkVEajcycDJwZXB0MkZsM3VwRWxTYzM2NlJaazJPeTZ6?=
 =?utf-8?B?V0Z4eElxbllrU05YVGI0b2Uybk9kQkF0QVVvc05UZnBkVEZyelNjbGJZMzhH?=
 =?utf-8?B?VmxZQ0VITkF0UmUxZldHRHpNTWd2LzdVcGFXNXg3YWhFTG9ZUzVhL1FXOW5i?=
 =?utf-8?B?VzU5cHUvOVYzZEtLMjliR0x4TU9oTE5xZDFUMnpmbGxKcWdKQzkxQjNpYWpE?=
 =?utf-8?B?NWxOak1ic3lUeFlJVmNJUTZyTVE4WTZrU25xZVRhaFArZGtoQ2lUemIxMy9k?=
 =?utf-8?B?cjBEVlJRMFh1Tnk3OW82MmwrWXBMSjFacUduTVJscWViSWZrS0ZOd0xQbWZo?=
 =?utf-8?B?dWNTNVcvZ1pPME1vdzE3S2dIajJLSy9SaDB1N1NjMFpwdlU5Zk81aGlFZmox?=
 =?utf-8?B?WFFaWGNTNGcxRG83djBjMEFVcHljRldKY2ptN3lvVFZNTVhzdUZiNHJoMTNm?=
 =?utf-8?B?ZnB3NkhTdGtna09ZdmN5YnZBY2gwZzM2dEJmWUtkTmdwTFYrNzhFWFBVYTJZ?=
 =?utf-8?B?TEpsY2loVlNaUllTVFptMXpjWGhYTHBpR0dwYXE3SmdXWkxCK2VQbFNtSFVk?=
 =?utf-8?B?VWJ5dExrSTRycVFkYmFIUWpvOUdocTk2TkFNem5odmZsUXVTVDB5UzlsNzdy?=
 =?utf-8?B?ZHpsRHBLWU9nL3F2UDBvSDN3VC9yazZZaTNJbUNSdlpvd1pUclhYcDZQTG91?=
 =?utf-8?B?WkdmZFdST2E0THNKdnRvZUp4VWswWWFWT0s1VGZSMDA2WjVvbkRCRG9sUk94?=
 =?utf-8?B?VmhZK05NOE9ybUF2WlNTMjl4UWdLbm5kUTdFbE80MVJrUVVGZUlTaElTOXl2?=
 =?utf-8?B?cFhuemhOZ0Z1VytqTUNDL3AxUFB5WFVteHE3MG51VDYyRXhza0lONU1FaWpT?=
 =?utf-8?B?M3JhNzM2UmZuRWd2OFo4LzBuZ1VCYzMycUJpcXhhMDhtbElYNUltcjlNUDI5?=
 =?utf-8?B?NzkvTE5WaGVnZXMyTSsyQ3doZHFLUExTQnRBbGEwQ29NMXQycW8wL2FNUG0w?=
 =?utf-8?B?ekdVN3J4RlZsWVNneStGTWQ3K0xPa0MvMjlZcHZTTFRXdUxab29KRXRidDB5?=
 =?utf-8?B?Tkh5WlgzUGtuOEF4VmVCQnRVb2R6Wjk0SDl2U2xpY1pxYlpCeGNWR09OellH?=
 =?utf-8?B?ejVGeVRNdmxUZVh0NlJRRHVSMzUvVW1McGQ3azhRaU1UcFdYdWhiSDhFd2Q2?=
 =?utf-8?B?bVJXQWN1MXB4YlBpSzhoUXFBb2xVQzFtT3VIT21jWENWeDIyckZ6L1JyeFpH?=
 =?utf-8?B?eWUyanlJVGZNWnRXVEZPb3JDT2hCS3pQUDE1S1J3d2Q2ZGZndnE3Y0NYRXJY?=
 =?utf-8?Q?ziRORPU500GdM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emdURlhzdkZGcHFsUXNjanVPZ1g3N1Z3cUIvelhpTmFGSDRGZzE3NXdVTFZE?=
 =?utf-8?B?VG5scnVPSTdvNEVGeTBWZWxlYTdjK2ZUYURtbUdwNDVoRUlWdlpVNHd2WitT?=
 =?utf-8?B?YVpveFRZUi9yTnpweXlDSmZ4MWthdUVJbU5qVCtlejlET1BFUUtPZFQ5bXBE?=
 =?utf-8?B?QmxSQ1BtNHllT05yaXMwZUhlTVB2NW0wRFl5NkdNY1JudWZMMmhNR1dERzZW?=
 =?utf-8?B?ZlF1ZUJ1d1ZLNWMxa0VDSjBIY0QrN0sySmdRR2FWMW5YWEpwU1BmVHVHR0tu?=
 =?utf-8?B?V0NwZXZxYnN6VlhjUlpPelpUOFppTXBqUWkwd1gyY2IxRHpjTms3TUNqNFRT?=
 =?utf-8?B?WVFVYTN2aXBjSytFYmtVMEhmVnpsZHpudXFDRlFZOHY2dm40ZzhYMnJmRnNQ?=
 =?utf-8?B?UEppNTNLdFBqbUt5Q0Y0ellUT0MxOG8rVEczUldENlpSWnVncVorL2NIL210?=
 =?utf-8?B?eSs2RlNRalZRcGN1cDVqWVA2ZHBPY1pML043UjRRS3NQbUk3ZWJzdGo2azRE?=
 =?utf-8?B?S2tXb04zUVBXeFVtdnVrVHNYWG1Kc3dra2NWLzdjRTFoNGVmRVliQkxJSFBU?=
 =?utf-8?B?S1lWb3BqZzYrbm5QTnFDV2RweEJBOWlYOWFaTmU1N3ExSVB1Nnhza3hIR3lI?=
 =?utf-8?B?V0tWR1VHWFZYcUVxY0U5WG1hYVhZNHVYeUtZbE9qQmpDRjhTaTRYUndjd1Mv?=
 =?utf-8?B?aExCUDNueCt1ajQyZU84TXRRM2V6Z24zNGE4clhSTGRmOGsxKzNtMTVzSGVl?=
 =?utf-8?B?K2FyRm5tRERSbTh2VjY3ck5rOWNkUFNTb1VXak5MMm5MTmlndHZ5a3RydUdi?=
 =?utf-8?B?NFNIZWwxZkRHS2pqMnpPdExYTk1aSG9QdVN2L0dnc0F4eWhSdHVFeXA4QytS?=
 =?utf-8?B?Wkk4SUNYYjA0a0hKKzNoQWd0ak45OVRGSGJuelZLMVpVb3FxZ0tkT0Rhd0g5?=
 =?utf-8?B?eWM3L1BrVGkrdjlVeEkrd2JIZ0cwYjlOc1o5aHNXRHBXSDAwSkFXT0tENDd3?=
 =?utf-8?B?N093TW9iNFJaMGdPZVhXS2lPdGo4RGQzWVhITytBNTltSTVpSjBkRWZ0L1BH?=
 =?utf-8?B?ait3NU00NnUzSWk4YktQWWdPQStqOFhBdVQ3TVVMRW0xRHBDL1J2OTc5T2d1?=
 =?utf-8?B?S3JJN0xtdjhLQkhPRU9zamhneSt4R01wVG9qNEFVWHFGTy85UmxtMUFaQlNh?=
 =?utf-8?B?L2krWE1tMXphUTlvdUlxWi9xWWRkcEMwZFBzNjdrV1FCTkFwaGQ2d082NkJX?=
 =?utf-8?B?TktXUzVlbmV3Mi9MTVcvSDYvTHpGMUJHYTJaSk5MdlNzZllWUVdRMlRiaVFN?=
 =?utf-8?B?b2pEcXVQL3EyQlcvc1pWV0lJZ0tHMmt0WWJ5S3daZ2tJMUhaS0hPMTJYTXh6?=
 =?utf-8?B?VzhpVTBtcUpwNWtWY0p0UlVaTUtTbGZkWHZBOGRPREJ2Y0hIcFpFZ0pCMzZp?=
 =?utf-8?B?bW9uYld1QlpReVBkd2hBT2lOeUM1T3ZKdGJ0ZmJNdUlHYUxaZk94cE9TYTFx?=
 =?utf-8?B?SUt0Q3lGSEl3Qk1tWFU3cXJlUDBQMUtUQmU3bFRJOXczMy9LTU5CNk51bEtD?=
 =?utf-8?B?ckFKQkJVdTdleDVNa2VPRmNUWTQwVnIzdjlFOUFva2w4ZlBWeDd2eWRPMEht?=
 =?utf-8?B?YmZsbWdiUWNpYm1wOGl5OXcwTGpaTzBOSlRQaWE5U0t5eEUyT2wzQUZ6dXBX?=
 =?utf-8?B?cHdLaDMrQ1NvUDRBWGNoWmxUM0h1dUVxc3FPeFlSSzlzM00xamdTQ1o1TC9L?=
 =?utf-8?B?RkNKam11NkFJdnZ0a0lJWXFhaXlvMmVLQy9ya3ExTzlTOGYrTWNkWHJBcUVM?=
 =?utf-8?B?VEtRMG5FTi90blUybmk4Y09QT1Q4cjk0SW1XRktXNXowcWFCc3Q3bXoxZDlS?=
 =?utf-8?B?YjhNeDVPdWY5ZUZZcXRIOEQ4eUZqcVZRS2VtUkErdVM5a2Q4L2JGT0dYQ1pC?=
 =?utf-8?B?MjZ6dXRqSDNwY09JWGJzajhkc0tYZTRhVjZpUlhqQlJYVzhBaEpTV0xvQk56?=
 =?utf-8?B?czhPa3dNWUZLcmJ0SGZoc1ZLanhHeERVK1BzR3R0ME01TlNqbmhlc2gyajU5?=
 =?utf-8?B?dFV2bnppYUhTKy9GV2YrRU1SZElHWmZFYTEyRkhnTDVwOURUajJZb0pWaFp4?=
 =?utf-8?Q?Fwx4gx5CKgqiHfrhCESOZC/7D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nsV6ESuEib2hOzB7ft0wVNf4hx4Ro0O+EEMo3TKwUvTs2ISTM5f3gJs0y7Q8KIkPoCEQUgPHJvgluvtxOgKQmkD8vqngnG0g1ZFP8qN53RVmm7hCakxGzlJib00xcrRqCJ8Y+y2smaef+wriqpgf+R5PNG3zmfz58PVGy4sZtEZirgrzHEJXfmiGiUFSJILr5mSR7kndAaKBidDULOnjE6KfombAyJ51MVl6+zeAo4xRvzqjapwQYinJjwvf7Xa9skuEslUqYerbCXk+DdWAOOeG7wj3RSa0qgdngvjbEw4BSUvl3ZgCRou+Oqjvq1VbbUi8FDS8upXHUUYzO6bEME3Y4dQDwLz45p8FUQI0/GgsG0hpYRiRY0h/0jd8+ipCIirhhQtT8nNthnrYyE4Frue0g0UydIQ7FlWd/oI3RHAEot+y0Jzn5MdiQgaSQjrLZfqPI5YT3UcEVzZMqM9cvLZSax18ZqWWbhzf5QUCf2fZfyxL/iYNSFTqW3KUFrewP02UJ8dzQrTf0EM1oDk8rz7E9nGF09INGwkJEpwSHHzgG6X03s2Cv2xqMjBDaWTbd/B8lhEOVKNE6/5Dc77CA1WraT9XUAGfRs2qIJgj+xTYksLJ+1Hxqfx3PDOITukR
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ade4e5-4a5b-4e20-6f84-08dcfdfc59b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 00:45:45.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aHhUmXJ96FYuDVpc9pHzUOd8uXxy/J1Y+2/PIgF4xdieKSAk7/+yMlZaD8F25S9fzlX/Jz4KHoHXIkKoONMUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB7060
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: UaZCQ9ROitVwox2SI3HRA0n95pxYL7Ak
X-Proofpoint-ORIG-GUID: UaZCQ9ROitVwox2SI3HRA0n95pxYL7Ak
X-Sony-Outbound-GUID: UaZCQ9ROitVwox2SI3HRA0n95pxYL7Ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_08,2024-11-05_01,2024-09-30_01



> -----Original Message-----
> From: Brian Masney <bmasney@redhat.com>
> Sent: Tuesday, November 5, 2024 5:10 PM
> To: Saravana Kannan <saravanak@google.com>
> Cc: Bird, Tim <Tim.Bird@sony.com>; linux-embedded@vger.kernel.org; linux-=
kernel@vger.kernel.org
> Subject: Re: Boot-time initiative (SIG) thoughts and next steps
>=20
> On Mon, Oct 28, 2024 at 03:=E2=80=8A33:=E2=80=8A29PM -0700, Saravana Kann=
an wrote: > On Sun, Oct 27, 2024 at 6:=E2=80=8A30 PM Bird, Tim
> <Tim.=E2=80=8ABird@=E2=80=8Asony.=E2=80=8Acom> wrote: > > > On Fri, Oct 2=
5, 2024 at 11:=E2=80=8A18 AM Bird, Tim <Tim.=E2=80=8ABird@=E2=80=8Asony.=E2=
=80=8Acom> wrote: >
>=20
> On Mon, Oct 28, 2024 at 03:33:29PM -0700, Saravana Kannan wrote:
> > On Sun, Oct 27, 2024 at 6:30=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> w=
rote:
> > > > On Fri, Oct 25, 2024 at 11:18=E2=80=AFAM Bird, Tim <Tim.Bird@sony.c=
om> wrote:
> > > > > =3D wiki account =3D
> > > > > The wiki where we'll be maintaining information about
> > > > > boot time, and about activities of the boot time SIG, is the elin=
ux wiki.
> > > > > The page we'll be focusing on is: https://elinux.org/Boot_Time.
> > > > > If you are interested in helping update and maintain the informat=
ion there
> > > > > (which I hope almost everyone is), then please make sure you have=
 a user
> > > > > account on the wiki.
> > > > > If you don't have one, please go here:
> > > > > https://elinux.org/Special:RequestAccount
> > > > > I have to manually approve accounts in order to fight spambots.  =
It might
> > > > > take a few days for me to get to your request.  It's very helpful=
 if you
> > > > > put a comment in one of the request fields about this being relat=
ed to
> > > > > the boot-time initiative or SIG, so I can distinguish your reques=
t from
> > > > > spam requests.
> > > >
> > > > Can we instead keep this all a part of the kernel docs instead of t=
he
> > > > wiki? Couple of reasons for that:
> > >
> > > Ideally, we would put some material in the wiki, and also
> > > produce a document - some kind of "boot-time tuning guide" that can
> > > live in the kernel tree.
> >
> > This is the part I care most about being in the kernel docs. Eg: what
> > configs to use. What commandline params to set. Dos and Don'ts for the
> > drivers, etc. So, good to see that is an acceptable option.
>=20
> I'm interested to help contribute to a boot speed document, and I
> suspect some others at Red Hat are interested as well. Personally,
> I would prefer to have a section in the kernel documentation over a
> Wiki
OK - that's at least two votes for an upstream kernel doc.

I think it would be good to have a boot time tuning guide upstream.
I hope to augment that with a tool that will check for various
items or conditions on a machine, and give a list of recommendations.
This could go along with the tuning guide.

However, I would still plan to collect some information on the wiki
that I don't think will be upstreamable.  For example, see this page:
https://elinux.org/Disable_Console

The first few items on that page could be sentences in a kernel tuning
guide, but the data from actual uses I don't think belongs there, as
it will quickly bitrot.  (Indeed the information on that page has already
bitrotted.)

I think it would be useful to gather this results information on a wiki, bu=
t its
possible that if reports are sent by e-mail, just a few lore links would
suffice.

> Besides arch-specific recommendations, we can also contribute
> some boot speed improvement techniques that we've done that are
> specific to RT.
That would be great.
=20
> In addition to the recommended configs, I think it would also be
> beneficial to list some upstream patches that improve boot speed along
> with the kernel version it was introduced in.
I think this would be good also.

We should discuss what a kernel boot-time tuning guide should look like
and how it should be organized.  Starting this may be one of the first
things the SIG does.  The other one may be a data-gathering tool that
I've been working on, that (of all things) automatically populates a wiki
with boot time data.  I will explain my intentions when I post the script
(likely tomorrow).
 -- Tim



Return-Path: <linux-kernel+bounces-400545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5F9C0F06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6551C232CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F992178F6;
	Thu,  7 Nov 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pzt5oOP7"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021D22338;
	Thu,  7 Nov 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008131; cv=fail; b=mdzsCvhetYNcsEIWS6pwxIIXsodRVdAEFJMnQN7PF+61swMXknMUGDw4BK1wViR/b1Mm9WQh0IbKW7X4gEpma1vJvItB5LGdJkTQpXMQshDLElZscNSPlRpjHqiD8+IBrfwadfO33qESn848+UHgjUa8sehhoCnZQZ3MB7tNdSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008131; c=relaxed/simple;
	bh=HegJFuhuIFwtCTDwztoAwZqEl+MmlI2n6pmHpywTUWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lS3lkbLJzUHDFvMUS5gkD5NHB60Mv4J/QwP5KaBF9iIJ9u5ci7sH7NRI4mexOCA+4jL2Iqg4SnEuiD72Mg+GSGQ4PMekU+7+tjWk5EdtIPz6Y33n8LdMvSwkp49g8VCZKPGg1CzrGzIK3khB9SSktAFkgjE7q7I9C7gr5cNxl+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pzt5oOP7; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IX8G3008365;
	Thu, 7 Nov 2024 19:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=HegJFuh
	uIFwtCTDwztoAwZqEl+MmlI2n6pmHpywTUWs=; b=pzt5oOP7Wqr0/+UP2M4UJLn
	LEyH3PdRk5Hd6E8yS58adLTHhfTOzJiTLoEMMqx3ZAOare+7NSxEY/VS64RlNPaG
	9mGAd5BnPIDW5XhrwnTvQTM4j6gS+RVB2/Py9i+F3uDFHKJvWVtNoUZ/8qcrj+Yf
	NQcHof0D4/6uB244MHN6Xv4N64IOd5+xma+7woCHLJikMHU6/+xp2O2GTNypBSg4
	VYmoszmYcHIZZmlpMgRXF5w/kbGTMX8HscBeku3fzyIH7YTzGWrshkqQaTo9FEho
	qw6rl8lX3bMhu6cgZKrqdyA4q0mQsnQHBObuMO8ESI7xWLEGe7lRFrRqF6w3z0Q=
	=
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42nc3tcsqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:35:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPvP8IjLaGlsuGRRegiyN2DfnF3Xx11SWt1jyktyIBTKVNq9p4s/Bp89x9CeZjQhnThvE9dbebErPf0i83pW6UYclMnWC8v3zPam8pZQbjIaI4pUZTPkVuaGCmCB88LceTfO130982fEpTGHTNg8Nz+u9N0kKRtjz6OIp9O4gMJob4lUC1VkiIA5l3gY+tg2a1i4D7vg+zYsimpIA+rlXLFVriqMu60uDCjjitp2/RH4RRb5jzKeQC6eckSjmjkUNElZerzW8YBm3eXqNiAU6v3xYyj9RTB3lkBNpddOu3EsJH/SYWmv984z0RJzsnWNNmKxUfoGJ9poEKXmQnlZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HegJFuhuIFwtCTDwztoAwZqEl+MmlI2n6pmHpywTUWs=;
 b=WAPx7VxG0OMTVKyEn4Km3+0zzRR5Fiq79ew6ih/Jl+YnOeYn1LKXZCMNAVael85/qIOBcbDEEScm6WBJ0ypeSTx9OqUchK+yvTf1cz1sK1gqzHnRFR/a1R8wmc4NTBvv3GLZ60RRwKlkjvrUzFDmgOd4+etTXjoqyUdNf7CQAKavUQ99T/pvvTeMVOuugh99BkXEcFFd88+nksq8Q5r+cnCRIuEAfJMCBLdC78wuyGjgiFV+MTqt1Miw/waoWRsA8VKO85ChE4CdwyNaOCeKBfGCT9UyHC1BGX0YCGfq87XLJi414Sv/QKh3KEtUiFcxzd8e9tw0+28zNUFV7O9khA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by PH7PR13MB6537.namprd13.prod.outlook.com (2603:10b6:510:30d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:35:11 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:35:11 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Saravana Kannan <saravanak@google.com>
CC: Brian Masney <bmasney@redhat.com>,
        "linux-embedded@vger.kernel.org"
	<linux-embedded@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Boot-time initiative (SIG) thoughts and next steps
Thread-Topic: Boot-time initiative (SIG) thoughts and next steps
Thread-Index:
 AdsnCeBneydgAwbrQsOuFQyqBOu5BAAb/amAAFavyuAALTTAgAGVsygAAADjN9AABoIhAABTSsRQ
Date: Thu, 7 Nov 2024 19:35:11 +0000
Message-ID:
 <MW5PR13MB56326559F5CBE58BB70CE24DFD5C2@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
 <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
 <Zyqz1LBDXZosrjle@x1>
 <MW5PR13MB5632276F33CCE4E18D0258E0FD532@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx-5r6+-9q1GCOry6PP1hALMuPbwSco7jdcNZ24MTMcBpw@mail.gmail.com>
In-Reply-To:
 <CAGETcx-5r6+-9q1GCOry6PP1hALMuPbwSco7jdcNZ24MTMcBpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|PH7PR13MB6537:EE_
x-ms-office365-filtering-correlation-id: 3140d6fa-e5dc-4ebc-2c4c-08dcff634b64
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3AzMlhodTRDcUN3TVlTYkpJaTBSVVZDZTdEUEVEN3VaQzZsdlgrczZwcmlY?=
 =?utf-8?B?RHAwSzN2Q2d4QmtBMjBUZ0NqYW5aNjRYRENNNVBKamJjbEtoUUllSm1yNmpk?=
 =?utf-8?B?VzFNbGxpVGtVcWg2OHluUkhHWldOd2MzZDBTV0dsWmxGM0JhNCtxV3NkMThD?=
 =?utf-8?B?VUVBWTR2Umk3Y3hSdW0wTklOcXhlQi9zb2szVkdkN2k3ekFqWkVoSzlyTytp?=
 =?utf-8?B?T3hQZkd0dzV5b2N0MGJtYmFYam14Qkltd3BybWJCTUtsSG95MFE2ZmRBbW9X?=
 =?utf-8?B?a0p1ZnhjZEpiQ3hUcXUwVkxlcitHMXdkMmg1bTR4dUhZMDRiTXlRWXhTc0hS?=
 =?utf-8?B?bmI4dDgyY1Y1U0hNcHJZTWp4djZBQ0QzaStadDgraTNQSHFTWUk4WWVrdTZT?=
 =?utf-8?B?RExIMkt3QzY1Qkh1SjZSSEJ1d2ozZG1RdW9PRjZQckpWOW9qN0tyU2ZUWEpo?=
 =?utf-8?B?VVRCVWJGNy9CeEtrUXFLS0JXSTVkOFNEdGdTa0VTbnFOVEsrOFltN1dEam9M?=
 =?utf-8?B?aW02dWFyTXFNNzNPK28rWDVRZDh4bjVNVHQvMUtxR3g4RkFxN2JFei82QWdw?=
 =?utf-8?B?TmlSOS9CaFF5UkE0WUx4OHlpUThFKzQ4Yi9Mc1ZvZmhZblNRK3cweUkvQlVD?=
 =?utf-8?B?S3VldEJXcjN2cE11SHlYa3lkK1A2TFQrYzdONHJudE9xVUhidXMvVHJiSkxp?=
 =?utf-8?B?dzE4dTY3aFBCekJ1eEdVRzg4cnJUN1FYd05YR2pyeFJkSmpuWGlDRjUycDZN?=
 =?utf-8?B?cFA4c0IxNmNsQTZ0WWxKbjNobmdldEZ0NzFIZ2tWVWJZcDJRR293MENpRkFq?=
 =?utf-8?B?bnVSUWFyNFIxS1V3WVZBbE1WNS9nRTRGNjZYQ1AyUGZvelVhWjJaeURrRTJr?=
 =?utf-8?B?T2htMVdWZlNDc2NPRTBnUGJoMDhUQjZSZ2t5eFltUUI3WjlpV1dRcisxakdO?=
 =?utf-8?B?K1ZXVlkzem9lWGZKUTJMK2VWY3p2Q0E5WWZsM2lmZnZGN0NITjB3N1hjTS8v?=
 =?utf-8?B?aUgxeUVkeXB2T0ZsVHkvY3NocVNXWVF5aFRFZW1TMG1tRFV5QWJFOENVTGJO?=
 =?utf-8?B?R1pGU0dGMTN3bDl2Z1UvTC9UZ3M2TWJlV1RzcStidjFkeGNxTmVYME5iNVcy?=
 =?utf-8?B?LzMzamJYSmlyWDcySGhUMVI0SE52a1lXV3BRUzBZaXlpUHpiNWJ2OHB5UHJy?=
 =?utf-8?B?a2o2TjhlSzVVOXhXWThHeE9ycXp0UlFENEIxbExjODE4OVVHYkx1Q3NiVVNp?=
 =?utf-8?B?SG5ZMlVSbzcvaldWRTZZSXE1Tzk3SkgrK0gzTnFuSGJwc1Y4dExjeFdLbllv?=
 =?utf-8?B?UFV3QjZ2NlNzcEl0bmpuZG1SUlJvaFVDS0RYQVFNdVlBSWQ1ZUdWQW9sUTNR?=
 =?utf-8?B?VFpMNHZSSCtnUG52SnVPS2FHTGJud0kwczgzUUxhVmFFd0F2d0V1VVo4QWgz?=
 =?utf-8?B?U01uVWVnOUlTcWhON1pGY2NKc0Rvc0NCYll1Vk0yYkZKRi9xMGlNUXQyTjAv?=
 =?utf-8?B?eGpLZVlQSUxFWWVwaWhlRFpRaG5mZGNTbkh2N3RzNW9FdERyMmJPeWlsTExZ?=
 =?utf-8?B?eHd0NUQvVHJMODJQSGVqdjVaSHE3MGxOUHV4WGNjTlZQNUp2ZXIvc0RqdDFN?=
 =?utf-8?B?UHFxUzk0Q0kvYUR2c3RJYzBsK3p0aitOc1FveitHUGhjZDcyNGNYWFBRa3F0?=
 =?utf-8?B?a29CQ2w2dXRGNjcxdjVzZjdweXN5blIxVit3RFlCL2lIMkhxQWtueFF3U1JD?=
 =?utf-8?B?YUJ5RERoQ092blBjSndjOEUyTDZvd01NREgzeXV5TEZoSE9YN282SEtvdEd5?=
 =?utf-8?B?Z1JhK0xYU1VxM2pnUXJpOHFhVlQvNmZGVFByWGtWbGV6UVh6VEJkSmp3RkRi?=
 =?utf-8?Q?7Qx+9HPfOn0+K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGsxeUVXQjJPRUlHOHl0anJzVGU3VGdnWEFHK0RWL0NtTHNMeVQvZWV1NVFE?=
 =?utf-8?B?Z1lJRkVaVkZHcEpONzFaUnhldGN5dlN6N0p4VmxrZHR0Zis3dkRuRTJZM1Fv?=
 =?utf-8?B?V1l6VUVYbUMrc05aMlYvazlsTmdsTFFIS084NTM1S2JmY3cvSXFZdVpEblZN?=
 =?utf-8?B?MTkrdVVDQXlOY2hoWU83UU02aVA1VkVKZEZNUzh5UEY0UHM1VE05cnIwV01r?=
 =?utf-8?B?MXZvOURHZklqVENVQXVnYWUzRG1WQmdhVlVKb2NJV1drY002dDBHaEw1T3BZ?=
 =?utf-8?B?ZDlOZU56enBFQlhSYUJtZ2JmdWpZQUJuYnNBS1ErWnhxR2Ridmh6RWZtTmRI?=
 =?utf-8?B?SmZ2bnp4NC91RlQyQTU4dkhzQjFIelZ2cjJrZFRVdHZwU1RQZ285Ky9RczVU?=
 =?utf-8?B?MDBCR3dkeFdjc3ZLclByKzIxRGJTcExiK2JrQ3MweG10b3Qra1NXUU5YY0p5?=
 =?utf-8?B?bFhiRnlmL1hQVitVZXkyQzhObTU5UkY1WDRrVkZlT1JodzR0aFByYjNZRnVi?=
 =?utf-8?B?Wi9UVGMrQlZRM3lUTDRTcTlnb1Vab2RPMk1Edk9LUnI4RGY2RlhZS05hSC9N?=
 =?utf-8?B?SFp2WWR1a3RvdGhVVFFQc2dzQWgvSDJnSEs3ZTgvZlBYbFpvZDZ2ZktkeHpp?=
 =?utf-8?B?WVlWWHdHeVc1SytYL21SVW5hTk9vNVBtL1hNYXRVdmh0TGt5cmVXL1BiekpH?=
 =?utf-8?B?cHFuMkRzYytjWVZtN2dvWElSUU9IUXdMZkVBWEhqbEVqL0FhY2EzL3Y2VG9a?=
 =?utf-8?B?dENHTVdvYkFlZXdOTSs3SGZpU1h5MjdxOWhMc05OWFo4TXROUlhoZk0wdjFN?=
 =?utf-8?B?bGRnc2VVQUNoQ21BMjE0WUNDenBNZGlGS1YwMFJZaXNrSmp2QjkyNkRpcWM4?=
 =?utf-8?B?OUJpVFVNNnk2YmVJWjJlTzBtN2Vob1hKTmxnaW5hZEl5N2ZPTERuT1NYTFFo?=
 =?utf-8?B?b1FNQkF6dTRhTHVWcWJpMVBaVmFvbUF3L2VXd0RINUhYU2JiRjAvNnR0NUhM?=
 =?utf-8?B?UDhDMCs3d29wZ1hwV2FzbG1lcEhBeUFFMXRkb3plbzJLUHFUWXdoeXA4YitK?=
 =?utf-8?B?Q3M1MGNMbnY4L09qYURwd3cxdVB6YWRwM2JFYlYyOFo4dzdKR2F1SGhxRHBk?=
 =?utf-8?B?MGxHeVZqekNQK0NZRldPZnN5MlU3d3FIcDQySFRMS3VkcTZNLzNWMVBLWUpQ?=
 =?utf-8?B?TmttR2crdUpwTEYwcktFQWRlM3RpbXBNQURVMGRRam9XRTIyOSt1OXF5Z01n?=
 =?utf-8?B?bnJVRWdnbEJhbGY2SFhNNlpZNGxpbFlSUEVvSm5WYUZTT2RXQnNoZ2RoWFZ6?=
 =?utf-8?B?aWVDSGxZNWwxTnltS2ZhZWJpQTNhdTFjWUE5NmFQbFphd0N1SGl5WDh0N2FP?=
 =?utf-8?B?WmFxUjh1WWVPVFdnYkQzZnh3UjFwdTVCZnJ1VVNWZW5teEdVTEN4SmFFUVlu?=
 =?utf-8?B?MDU3eFMrZ1dNTHhPSkZxYWlTUTEzM0x3RzhRSm92WDlwcktpblcyaUNmMFNY?=
 =?utf-8?B?VEJHZ0J4M2pNTjZhOGs0TWpzQTY2NEhZTURlWkpIMU1ldmpBSEVFc0hQTncx?=
 =?utf-8?B?MDZQZEZXcXJNcDdUV2kyS2M1dEpGdENiVHN6N3J2L0RPc3NzL0pJTE8xdkg2?=
 =?utf-8?B?RFd1YmpqYnRuWTlkNHI2VTBWUEgrcXpkSDZoUDVWWUU1N013emdwN1l1TUR5?=
 =?utf-8?B?ZjF6c0F0NEJOOWljZ2ZXNjI3UGtCSDNGT3FYYUtuRDIrcHdnMUhEak1kckp4?=
 =?utf-8?B?d3Bqb1FNMzh1YVMxbFBHYzB1L0tNdkNvZjJ0ZFFlcjRQRG8zVVlUZFZjaVpB?=
 =?utf-8?B?WTRENjRHaE9hRlVsLzV5NEdzSk5xSjlZME5OZUZzeHNvTlFHVVdBK3crQm91?=
 =?utf-8?B?NmUxYzM3OVJXS3AvalFWQTNJUmtiR2tQdW5RZndOd05qRVI5T2dEOUZERkgr?=
 =?utf-8?B?Q3owWHdEL1pqSzJzUFBERitSbmlHRWtTNFdrcDZBcDROakJkUG1VaEdnNXg1?=
 =?utf-8?B?RmdyWkJYT2FwYjRGVkhiMCsyVzJteVEveDVvdVhybzBQbjhRTW83L2R6c21a?=
 =?utf-8?B?dGlxRk5Db3I4d1l5WExTaFlBN1QzVXJkVHlIZ242TXNORW9WdjFXOHJXMUNO?=
 =?utf-8?Q?mzGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T5MrIDXN3RhbZAmSEo//7hVcTPj6LtWgZ/TbyOch5NUXzgN4P71w/KuOxs6CTbjjZTFXjp4qJ04RBeLgDMYowFPjAzeXw420cz7ZZWKTe/7FcnAs6lmXz1Qf24spAuoB1d2M/3uShHyng6coqiDjN4f3Ut3I4WDXZYGLT6tpt16GgZyCwwW7Wv35mtTYCncWWHLdf7i0myI+7ZVMsqjIAy7UPQ1BS/MwfK1OQ3WjrMc1MfE9chskstHVfdTkYr4c+GajkH/yJDOvLuVhzfGU/WQ+sCS+gUTxpTiWMYSi/4ZKCsGwKtrDTiFDmynk0gljb1ovswpIKXO/YKlfrqAANXSz2+fKF0fiLVTv8gxHhC1LUO1+kXbqiBMRBla3MjPc5tPSbljCq0O7lh5TCD8UNSKsr05kMbG48ElA0iieE0NeQB90DgMQ9157zPmbdVnjrun0dFBT19p0wTkgFPbaDYKTHVwg5jSixevrwuyeHkI0IeBGHde//uDbQK6rq7+F7OzpQw41HLt03hva6QI5MvaeN4tPNDJRnEpELJzPh9skrpC/iStq1NE7A3BQPvEUYyS5lLloLKWng7xcv0lPkHPRzD7EqU5Mz275TUT2ceR51m5RN+/jAmnN6obdjHKU
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3140d6fa-e5dc-4ebc-2c4c-08dcff634b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:35:11.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lQAlOEL+vh3eAHeocULUweV/3p3uKDos6QoUhONAXsrcteMAw4fkgQXwX4LhPYZUBOcXNGAwSH6ErHyitdvkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6537
X-Proofpoint-ORIG-GUID: _4vFFruw4AbqSd6tGFm-ZLi7GiVLI8dN
X-Proofpoint-GUID: _4vFFruw4AbqSd6tGFm-ZLi7GiVLI8dN
X-Sony-Outbound-GUID: _4vFFruw4AbqSd6tGFm-ZLi7GiVLI8dN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FyYXZhbmEgS2FubmFu
IDxzYXJhdmFuYWtAZ29vZ2xlLmNvbT4NCj4gT24gVHVlLCBOb3YgNSwgMjAyNCBhdCA0OjQ14oCv
UE0gQmlyZCwgVGltIDxUaW0uQmlyZEBzb255LmNvbT4gd3JvdGU6DQpbc25pcF0NCg0KPiA+IFdl
IHNob3VsZCBkaXNjdXNzIHdoYXQgYSBrZXJuZWwgYm9vdC10aW1lIHR1bmluZyBndWlkZSBzaG91
bGQgbG9vayBsaWtlDQo+ID4gYW5kIGhvdyBpdCBzaG91bGQgYmUgb3JnYW5pemVkLiAgU3RhcnRp
bmcgdGhpcyBtYXkgYmUgb25lIG9mIHRoZSBmaXJzdA0KPiA+IHRoaW5ncyB0aGUgU0lHIGRvZXMu
DQo+IA0KPiBJIHdyb3RlIHNvbWV0aGluZyBsaWtlIHRoaXMgZm9yIHRoZSBBbmRyb2lkIGVjb3N5
c3RlbQ0KPiBodHRwczovL3NvdXJjZS5hbmRyb2lkLmNvbS9kb2NzL2NvcmUvYXJjaGl0ZWN0dXJl
L2tlcm5lbC9ib290LXRpbWUtb3B0DQoNCkkganVzdCB0b29rIGEgbG9vayBhdCB0aGlzIGFuZCBp
dCBsb29rcyBsaWtlIGEgdmVyeSBoYW5keSBkb2N1bWVudC4NCkkgdGhpbmsgaGF2aW5nIHNvbWV0
aGluZyBsaWtlIHRoaXMgaW4gdGhlIHVwc3RyZWFtIGtlcm5lbCBkb2Mgd291bGQNCmJlIGdyZWF0
Lg0KDQo+IFNvLCBJJ20gaGFwcHkgdG8gYWRkIHNvbWV0aGluZyBsaWtlIHRoaXMgdG8gdGhlIGtl
cm5lbCBkb2MgaWYgd2UgaGF2ZQ0KPiBzb21lIGNvbnNlbnN1cyBvbiBoYXZpbmcgYSBrZXJuZWwg
ZG9jLg0KDQpJIGRvbid0IGhlYXIgYW55IG9iamVjdGlvbnMuICBJIGd1ZXNzIHdlJ2xsIGdldCBz
b21lIGZlZWRiYWNrIHdoZW4gd2UNCnBvc3Qgc29tZSBwYXRjaGVzIHRvIHRoZSBsaW51eC1kb2Mg
bWFpbGluZyBsaXN0Lg0KDQpJIHdvdWxkIHNheSBnbyBmb3IgaXQsIGFuZCBjb3B5IHRoaXMgbGlz
dCBzbyB3ZSBjYW4gZGlzY3VzcyB0aGUgcGxhbm5lZA0KZG9jdW1lbnQgZm9ybWF0IChhbmQgY29u
dGVudCwgb2YgY291cnNlKS4NCg0KQSBsb3Qgb2YgdGhlIGluZm9ybWF0aW9uIGluIHRoZSBhbmRy
b2lkIGRvYyB3b3VsZCBhcHBseSB0byB0aGUga2VybmVsIGRvYy4NCiAtLSBUaW0NCg0K


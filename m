Return-Path: <linux-kernel+bounces-414601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1779D2AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371481F251F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACED1D0B9C;
	Tue, 19 Nov 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="YY02I0mb"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454618A950;
	Tue, 19 Nov 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033454; cv=fail; b=LxuSuBmqyO8amtMeKfqQvmHvytogSSOKflO87A4sV0y6Jb3yzMNUkRH/N9eE+61hyrXkRTuaULgTiP8HtcaW6CrHA+GC6Pn5GpSMjMQEKoJ9+nk+6YnH5drC0kKxInzvmMFjsfVoJAC5z3Eam59QUOW2B7nxDC+q0XU0ayJpOF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033454; c=relaxed/simple;
	bh=TL4ASsdIJSmzNHx/EC6uUpoSCdvYvYeoJNgvzfCeWco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6Hd/PV0S+tqe6bc9LoQfsnjxmlDnKCqlaEiEkD9nEBSoua7QCW1Urlh12kbtW2fcSrRFRMiH3OgPrE2nn6BdpyHni951//c3aCuGVlCPJHx8ip8+xbb+ThDoC1EN/spveknWt+lzwgH64VO7vgF3hklUo26pYHOJiuf9dlTZEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=YY02I0mb; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFmDdb002806;
	Tue, 19 Nov 2024 16:23:55 GMT
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011024.outbound.protection.outlook.com [40.93.131.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42xhkxhbn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 16:23:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqd/jJBsjht/wDNLOB0fddSfqSPQVkVtKVmQn9zCt/LW04rFxcqT71cauEQu9mnwdvTVy/qS/SEU1ddpPoNoDVLLd/s2KTN39U6FhEtbiq3/5/oMslDo3V76WYj99FBcDVbQP3aWLYQ8Qi46XG8brQoQB7qZT4BES/OMMpgcM0BmhcrYnr7YNyWLEi2K2f6TywPZEv9qUMeuD/vcC7vKqLLeQCBpQyFgrzeTfqH5uvPEymE6SqC6kDIl6JIljrrmoJ5A/ardLPAwYU4DTvk9N4Yn4zLrr7YJblqHd+Y9OHlfJ6Y1En33xv00E0g5VOhox6UVmJADOsQ22DoIIpUMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL4ASsdIJSmzNHx/EC6uUpoSCdvYvYeoJNgvzfCeWco=;
 b=eODHbs/pmzL9bb4f2GgkUCAUT2VOrO1zLuDPFgUKnqMi4B08EvbAdn+8ThlxaGtwEhiqhh4iBwglspURiFV8FDQiyF9H+QpQ9Hr3wwkdjnrQ8v0JjCI5hjMWc4HdduBDGX7o6YfcVFmV+tHX3Ivledw8ZSzl0AxcmYsS/YBJjBq4HojaDhLNL9hFGVqA7GAvIbtyA9On1OI7lgNqr85o5iJLAWj5KPmifG/4g9GJ7DL6Kv8JmRbh9GdzrR+n6n0/zDpVRY0QjrwJuFusI0m1HVsIIIDJxldIMpA7RDCZ8GUmlz4yfhfJy2bnol0UYLQoydhjSNEW+NfNziif/AbsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL4ASsdIJSmzNHx/EC6uUpoSCdvYvYeoJNgvzfCeWco=;
 b=YY02I0mbOuSSitqleH0U0IHlx9Y2aeRvx8MGyPAjw7/kXvpXYIrgcdhZ6RFaZQjCOub3eyUjntBtMAS8anh9cHkpk6dn9q3IL4XQBwBNCiqdb0SoOV7oKRrDxi5ONkcuZYZ4Kjn9+f3Ne6EzLdRthbDIuR3sHnadI4L3W3G0oK4=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB6292.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:83::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 16:23:48 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:23:48 +0000
Message-ID: <807848dc-f299-4eb7-af7a-9f7575ff82b8@blaize.com>
Date: Tue, 19 Nov 2024 16:23:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: Add Blaize vendor prefix
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
 <20241115-blaize-blzp1600_init_board_support-v5-1-c09094e63dc5@blaize.com>
 <c1885e24-8051-4c91-9870-18eb4218a2ff@kernel.org>
 <bc471aeb-e9fd-4aa9-9bcc-a59d3c2e47b8@blaize.com>
 <c866d4e8-77ee-48ca-b6a8-5f56896b072e@kernel.org>
 <09170fdb-018a-401e-a186-ccd0f5e993d8@blaize.com>
 <38c2c941-42e1-4d7c-aaa2-3c11dcea4e05@kernel.org>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <38c2c941-42e1-4d7c-aaa2-3c11dcea4e05@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|PN3PR01MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3e3c58-3137-488e-2b93-08dd08b68bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3JsaFNQbW5IWldDWTBNRUZldk1OTFh0MnIrUEU0S2xBZWNaSnlIb2ZSUzkr?=
 =?utf-8?B?citKb0NITTFCYnFQa1NWeEFJS2JtNEE1VU4zcFhhZEVaZWhGaVd2NjllZDcw?=
 =?utf-8?B?ZmZpM3ROaXRoVFRqd1pYSFpLeGdFTTlORTNWdlN6QXcrTmdyKzhCTEEwYitV?=
 =?utf-8?B?c3BmNDhYMVNCUFlxZFVXOWlPMnNUTDVTVXNmTkJzZmJnWGRUZUdVeGcxSTBj?=
 =?utf-8?B?UDExWGVkeCtMRUtFcWRhc3Bkb1R2VWkweGdIdWUxRHUwS1ozenFyT3JmYXAr?=
 =?utf-8?B?aE1jU0lFRDByS2JUajU3ZHlBYWtGam1DS1dmTmswOGdQKzlYMURWREF3d0Za?=
 =?utf-8?B?bGJDQk1xSmErZmMrSk9qbGl6b011RzN3dWlhWGVPczFLQVp3cFM2T1hLZ0Zn?=
 =?utf-8?B?MHVoWVNVU3RnTFNtQ2E4OWEwTy9GNklXcnhPUGtyZlJ3Y2FQM1hEU29oVFc4?=
 =?utf-8?B?dFkyQ0o0QVV6OEJjcGE5WEY4WEhPaDRMZndSVTJxb2Y1WWNISVFIa0JrejJl?=
 =?utf-8?B?RjVnZmtPNnFYeVk3MFROOWE2VnAvODFSbjdhS0d4Uis1UnNHYjJOQWxDcloy?=
 =?utf-8?B?TUFhQ29GQlVZaHJsQXE3R3E4SjBIcUYzblZZRE5NY3pLTmxEWVFyV2FNYmpG?=
 =?utf-8?B?bWxNZ2RNek1yc2NhdjV5WmZXZWI1d1g3WHovRFNXdk5wcW5HZXlnNVU1Y0Z2?=
 =?utf-8?B?T2VtQ01nU1UxUXRpVWJiNnFSbkhGUktqSndBZituSUUrd0lHRDFxcUFieXoz?=
 =?utf-8?B?ZnZvQUVLTWJEWWZGVWtqTDJlWU9yd1VkdGpmVndUbjk1dk40ejdwNkl6WXpx?=
 =?utf-8?B?b0M5VmErd2hUcnBIeWRCN0VMMjlnOG9Id25zczlWWjJnRVMzMmwxM3NlN255?=
 =?utf-8?B?dlR6TTM4L09ZQ0xPZnRPY25WMWdvY3hUT3dZQ2VydVNyRDFKWDhwYlJ3a1Zp?=
 =?utf-8?B?ekQwR0VsOE9TaTM4NndkWFlKVExzQjZXT0FoV1RJYnJXVEZMUkluK1dXMUla?=
 =?utf-8?B?eld3TTFNaTJtZWNDS1NlUkVoejVuZzBZN3l1UjhhYkdGSXZiRmNDMnpDaDB1?=
 =?utf-8?B?eldLRUorZjhvNndUT05sb2FqRjdQMHNJa254MDJ3MDBDUFZOMEx2VVJjaHlD?=
 =?utf-8?B?c1pTMytxc290V1BoeHorRmx4M2ZwQ3RMZmVtSG9HR3lqZDdSVmxSMUJXQ1cy?=
 =?utf-8?B?SEo5SmY1ZzREL0UrMmd0RUpPL2NOb0VHUFoyNGFMMlRBYTU3SmFNaVN0dC9z?=
 =?utf-8?B?b3d6d2VNcDlkbXJLVi9tZ05GdVk1ZFRRNVprS1NNRXUwTDdmcVZlZFJGdW9k?=
 =?utf-8?B?aFJaUDFGWG1EYjc4VUQwa1VCMGdRL1Fkd1J0T2YxUjlJRGJ1T1hMYTZLbzFR?=
 =?utf-8?B?ck1PQ0JuTDJqdWFoYmVPUkNldk9sNGN2Y2xnMjhWV21QNnNYSGl2bjhkbk5h?=
 =?utf-8?B?enNiVU1XRzlCRW14QXpReE1obVI2eTlRYkJkTnJQVjN5ekhyUnRteGZWc0lp?=
 =?utf-8?B?L2Y4WTVoTmljME1GMmtraWZzV1dwV2JkWGtHOTkvZTZTdFR4N3dTUE4zcGlw?=
 =?utf-8?B?QnVRalNRV0N4aXpzaTdYbFJ0eVdSYnhjbGlHRW4xdmREaE9DOFB0N0dJTkJa?=
 =?utf-8?B?UzR2aFBOK3l6Tm40RnB3RmZrYnhGOVE4M25rUTFjSlRzS0YvZ1hOWlRxNEN0?=
 =?utf-8?B?aHFlenZNU0tlQjlNTG44LytJNU50QlEzMEFIcFVXVEswaTEwcGFVb0VWSzE4?=
 =?utf-8?B?L3NBMDJaVklqSER0RG40QTlEczRiZjljK0o4SEZNN2NSeVhxQUpKQnlnaDlD?=
 =?utf-8?Q?pa42k0dVGeXDKXBSI8IhKXcggIkXQmj5rhZyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhvMmd4bktMYklBejdmZW10dDd0aExuK1JXa0E4ZUFZcU5MTGI5endZV2d4?=
 =?utf-8?B?NldPbWtvNGd4clRzOXVFbjQ4RjFLSW95UHlvSWltOHQ1N2tHWmx1dXBsWG53?=
 =?utf-8?B?V3ptMGNkaVRCSXc1S1hLRWMrVmgrUDBCQUl1U0oyOU9UbDhOOS9ia1c4WlIx?=
 =?utf-8?B?a1ZQQkJiQzhsYXJ1cGdZZk9ubk42OHhtNENsUGh3cjRCSGgvV1d2M3hYdS81?=
 =?utf-8?B?ejdySVlDUHZ2TG1lcVkyVEJ3eVR6dzBmTEpnT1RDaGVSUE1FSkppQm5Ecjhj?=
 =?utf-8?B?YlVxM0g0eWxvdWF6WEhwdFlyOEtQcXFMdHdDUmpUMG13TTJYY3hhL05HbU80?=
 =?utf-8?B?WVBTd042ektLM3JvS3lHSUVxTlZQTDJZTC9NZGRSNmtkeGthcXdhV2dnZWw0?=
 =?utf-8?B?VXJva3lHb2dtb1BjMzNpQzBlRXYwakJkMWZjMC9COE5Fc3dQRUNpZldtb0RF?=
 =?utf-8?B?cG03cWZJZm5VczJoSXhLVlNrQk5SM3lXUnBUOVFOWEZWWXcvRTdTZUdMWHdZ?=
 =?utf-8?B?bUNxb3VlSmRXbHdrMzFQcm0zVzE4RFJDQkpuaXBFMFd5V2NWVU9Dak1JQzdC?=
 =?utf-8?B?bWNmaEJWNDRsRkVOR3F2TTFMKy9MYnRlWkxjOFVHcjloWkFFOWVkcVJjWldG?=
 =?utf-8?B?NFBYK3cvMFRwU0hrU2FZdlJTM2lvbkc3eC93WGtINU1pSEVZN1NleWhpS0sx?=
 =?utf-8?B?OEtTeEtySzhFNUZSM0RXT2JYeTR0VFF2RGZ5QmU0bXRldHhaTlB0ZnJucyt0?=
 =?utf-8?B?VGRuTEpBRGdKTFB1cExKWTMxbi9pNHNXS2ZvdDZYQnZuNm1lNTJudHB2V2Ir?=
 =?utf-8?B?OXcrNE9STzkzWVNJc0VNNHZPVm9rNms0Z1Y4UGVaaUVrVks0eTVWTSt2dmtj?=
 =?utf-8?B?UGtYNEQ2WlR0MkFXSU1SU3ovbEpwYUZTakNsNTF5ZDVqdUpzLzRpREJQRjlo?=
 =?utf-8?B?ZEpGQWRTaFVvTUdoQjV2c0plNzBuaCtqN1FlMHZycC9iMFN6L1g1WTBNUW1W?=
 =?utf-8?B?YVJHUysyNjZjZmpGVFJrL1pwQWZWckl1L0pLSWM0RktRemJQMEgvVG9EY3hH?=
 =?utf-8?B?eWcrRnVTV1pZZVBqOGdMVlppQlFySUJtaWZ1QTk3aGZLTWFUSjA2bVlUY256?=
 =?utf-8?B?N0pnVmhsYms3RkllVWdoNTdEcG4zYU9ia1BXZ0hTTmZqSGo4ZEJ3a3JkWlFp?=
 =?utf-8?B?RmZURkNORDNEY3EwQ2ZUdUNtbVowWSsrNWp3cE9QdC9PbDRVTHFRWmtQWTFC?=
 =?utf-8?B?TEJkdWZRbERUcHhnellsdXhoOENLT3RxL09PTVhzZWYzUnUyRU1Fd2ZOVXNu?=
 =?utf-8?B?amZSZVJoNTJkS2k0VkZ4UFoxckZMYzdqdkw1eUpUN0hCajd1T3BnZ1FrNEk4?=
 =?utf-8?B?b0VXTitycW1HZFJIQVQ2bm5PT2dCVzluZHFLODFhTFF6NHhFcC9LU3hJdGhu?=
 =?utf-8?B?OEJoM3ZOby9wNUZKc2c5REZ3elVxMGtjdlpqZkJDVDd2RmxPMmpWa24yRVVJ?=
 =?utf-8?B?MkwyV1FmN2xGb0tsSEhPZXFVUDRWWFYzMmN4VHlkQlF5L2J2NHRuOHJOR0xC?=
 =?utf-8?B?S0JCMTA3SjVhL0xpMWZrN2pJbU02WmJ1ZWYzK2FubXN0T2pRVVlWUDFVNGZL?=
 =?utf-8?B?T1dBVCtNVXdYb3BJREpQdGtocnRzRWRaZW9KQ3A5SE9BTEV3amNiYm9ZNWNv?=
 =?utf-8?B?Qm5Hc2Nob0R3WGQ4WlYzZjlKR1pDa3VxdllLVjlmdmFzYjl0WTJES0kzaWQv?=
 =?utf-8?B?cEhkTEFlaEZqK1NLUWNrNVg3S1UxQytJR01BZVJpcmdhUnA4YkxGN0xRbXJD?=
 =?utf-8?B?Y3hKQnB1a1F0QkM4NzY2V3ArNVZXQ3NjUzNYZWJLdlJRR2RuM0xrcys0cUdw?=
 =?utf-8?B?bDJMamdQZC9oRVNlWWg1TEFXa2lLZzY3Wk1ZZGRPRWh6a24zeFlVR3N6eWl1?=
 =?utf-8?B?Z0JkYnhzTnFKWUEyUFNrM1o5MERJWm5sWVRMcXB4bW9kMjRoLzVnYTRPbmNs?=
 =?utf-8?B?UWlKNTZaN2ZQZWsrcGlsK0hGQzloQ284WmJLUkFZWUY1NEd6eEcySHdCelRY?=
 =?utf-8?B?U1Z5MUc0eXVOdW1ydGRIQjFQK2pFVU93OVhLS3hlRnlsN2ZMWDdjdWE2bGpI?=
 =?utf-8?B?NVdxSVdZRWxBSnZMblN6R1hRTkI0ZGJUejg3N2c4WlJlK05ybFJuSE9QK01j?=
 =?utf-8?Q?url/P9xiI5OhFjicJjJ3N4U=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e3c58-3137-488e-2b93-08dd08b68bac
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:23:48.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj10aIZiWVvG90gupK8A5Dn4oSX50Khrs1ND6+jqgG4Tmajob2dDovjKh/+qgtd8sP+FjWEH+WIyad7mclzrG8GAwKjJJJW2lVjEXuuR7yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6292
X-Authority-Analysis: v=2.4 cv=EPtU0EZC c=1 sm=1 tr=0 ts=673cbb9b cx=c_pps a=yS01Tg43EjyficN/GFY56g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=VwQbUJbxAAAA:8 a=3HDBlxybAAAA:8 a=SrsycIMJAAAA:8 a=3AJrCuAVmkvt_Fz8LK4A:9 a=QEXdDO2ut3YA:10 a=TucxLVmUXSYA:10 a=laEoCiVfU_Unz3mSdgXN:22 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-ORIG-GUID: WcjMaicwJRPZJoal8uXetvwP1ZGsfNoC
X-Proofpoint-GUID: WcjMaicwJRPZJoal8uXetvwP1ZGsfNoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

On 19/11/2024 15:52, Krzysztof Kozlowski wrote:
> On 19/11/2024 16:23, Nikolaos Pasaloukos wrote:
>> Hi Krzysztof,
>>
>> That's a very tricky error to pick it up. `checkpatch` on my end doesn't produce
>> an error. The header file on my patches starts as:
>> 'From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>'
>> I had set the mail account as Forname: Nikolaos, Surname: Pasaloukos and
>> preferred name as Niko. It is an Outlook365 issue I think.
>>
>> That said, when I was trying to send my patches, the mail server was converting
>> my name 'Nikolaos Pasaloukos' to the preferred name 'Niko Pasaloukos'.
> Usually it is not a problem to commit patches with one name and send
> with other - git send-email will properly add two From headers like:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20241119154245.442961-4-pablo@netfilter.org/__;!!FddXBOku!jmi9Ec3WZ4N6TfC0XlHzSmeISVpB19XDD-TfRyCDgkc6WpnZnjDJMz4bZWeoOY8X6YaL9GnapF-AIw-Cjyer$
>
> If your git history has correct From matching SoB, then indeed
> checkpatch on your end will not complain.
>
> If that is the case, it means your SMTP server *rewrites* the From
> header. Not nice... but what to expect from Microsoft? They learnt open
> source just recently and before open source was communism for them...
>
> You can change your local name to match whatever Microsoft wants to set
> or you can use b4 relay to send the patches.

I'll add your Reviewed-by on the patches and I will send again v5 patches
using the b4 relay endpoint instead of my SMTP server.

>
> https://urldefense.com/v3/__https://b4.docs.kernel.org/en/latest/contributor/send.html__;!!FddXBOku!jmi9Ec3WZ4N6TfC0XlHzSmeISVpB19XDD-TfRyCDgkc6WpnZnjDJMz4bZWeoOY8X6YaL9GnapF-AI5htzUil$
>
>> Do I need to resend v5 again after this is fixed, having applied all the
>> additional Reviewed-by? What would be my next step here?
> Yes, please resend a v5 with tags applied and fixed problem with From/SoB.
>
>
> Best regards,
> Krzysztof

Thank you for helping me out.

Best regards,
Nikolaos Pasaloukos



Return-Path: <linux-kernel+bounces-410890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C3C9CEFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3845A28AA76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5481D5AA0;
	Fri, 15 Nov 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="i4aIr173"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44011C07EE;
	Fri, 15 Nov 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684511; cv=fail; b=LJKOjlLk7j3htzJvIMi0zXR3Nu9CYS5fDRrw/1aLgPokj5kwkbJTwYFzX1ziqaPbUkFq8MML+EMTvAG2mANcqPAyDFL6DcMugXqw6DmvfDBAryNqSlG0AePgBcPGBw8BPmeIt83YcvMUV8c47Hut4O937EZezsFsK749ihBFeYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684511; c=relaxed/simple;
	bh=p7mBpTRWN1v+Ges6A2v72+R0/hFBouF6bHgciuRXTwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WVR6UOaoQMkzixD3WWB6p9DHj2fV6fFstyyaiocB9XUi6EBfKz2hnLTyiz0J/NfNRsfvD3K8Zdut1n7vwf6XeV0qTVD6oO9zc08caCe6aLolqtYvXTdiaVqmClsC8Ify8TUkx0vZwekWQSx8x6mF+2ZxD9T5e6DdcUrkxnuzfHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=i4aIr173; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEpvmZ003841;
	Fri, 15 Nov 2024 14:58:12 GMT
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011024.outbound.protection.outlook.com [40.93.132.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42uwr1sv90-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 14:58:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwHBHtTmjyU1jhsyDWhjR7IXsV1gc2sRaWLfWvloITPO+dQ//yyXk4kuPGsPizIOIypTEfmr7YaKcCAmylq5qZPKc5fp/eS6JCgeQRWdXEmD/zbPOj3wVEnx1WjCpdzdDW0ecgA3sqnRxrHPTp1VVb1/RNMVLKWZbYOtoVYhIMnPB24adgyumT+jDxxT9awePdjzBA9f3j8d0rRQZsqH2LqCqsQL5Z+9ZpBqDo5YRV/ZZrwsNu+RDg+VniBeNjL4uSxMsjdZEgDsxfFnplrQZLnkwflWBPNojF0lkIr5ZysMp1lHQjA8q3nWhm5PHcwvU5fuH9jB5kdvQ+dfAmq3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7mBpTRWN1v+Ges6A2v72+R0/hFBouF6bHgciuRXTwg=;
 b=eaR/u8k47tutUDV1BUWnu9hOIJeLoYImdkq3h0lmHOv4tCat2b6WmfH67zFyX7xXMwIxB4UsH0S8w10k2mgcHHlFYQOYunAqCwJEoNcA3CNhket1Aqr64hJT+ZSbbnJQWr/EC7vyRA6eGxlJTLb/SRS0aLdkPo6tWLa7ejcD/JA28xUIrNLzWDpCqPEMLw9JaITmoAw3YeiayxGVWVNHMgKFbweYRubvESX3Mb3lE/Pd+iGWO51vay8jrCR5jJ9u7yhfJz+sSYjwVBTkn5hJz9sGVsSjbN65LzE9yr6kGsgvhkvtq8VWnVKIha2aCpdhM9V0MGHSaa0ZGLB+e7zctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7mBpTRWN1v+Ges6A2v72+R0/hFBouF6bHgciuRXTwg=;
 b=i4aIr1733xyrrcmbbtOsbZPVJLTVtYDBpmu8hJF6fAbiMzzNqKuFu+uN/euuePtUH4Yqwctx7QLVDHKj/i7JXKN1SSmwwAm3licknrWZtCmuQj4qTyCcMOYsMq1fFwAzURNzXUSR1grPbSKRkfWSD3PCDW3Qf2dG8yk6VDcWCjY=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB9551.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:58:05 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:58:05 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones
	<neil.jones@blaize.com>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev"
	<soc@lists.linux.dev>
Subject: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
Thread-Topic: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
Thread-Index: AQHbN27GuwPLWhr5BEeq4mAGPnXTmA==
Date: Fri, 15 Nov 2024 14:58:05 +0000
Message-ID:
 <20241115-blaize-blzp1600_init_board_support-v5-6-c09094e63dc5@blaize.com>
References:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
In-Reply-To:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN3PR01MB9551:EE_
x-ms-office365-filtering-correlation-id: 0b04172b-47e0-4b44-6f46-08dd0585e8dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTBsdGp5ZElVTzNPZm0rdnlKckdheDNsWlZ5Tkdpd0FvQ2tRQXBIZzZkODFJ?=
 =?utf-8?B?R2x5SytJZUNVa09Bbzc3ZFJJOVAvZmljSmY1dlVpdWdDaldBODVZK05FLytK?=
 =?utf-8?B?QVlQeWdORy9OU0hFVmNwR1oyelBLSUxWS21NNXc3eDNQMzJzaVJUd01ZTWU0?=
 =?utf-8?B?V2hDVFdrSmpGaFdYTXhaNDNwcWl3QTlSODZ1Wnd0M09rb3ZicDYxU09zTmxB?=
 =?utf-8?B?M0Rsc1VEVFFvTGVFbGU4c0tRcEZyNmhZOXJVZHdyOURLS3FLdjh2SGdrUVNS?=
 =?utf-8?B?d1VlV1ZuVDU2UHYrN2VVL2VGWjR0WC8vSjZ1bzRyb2phUUhDLzZ1dDRSUlBi?=
 =?utf-8?B?eTlKeElicGJibjhJaFdzQkdkSm85Tkg5Nml5c3N1eVdHRDVkS085eGt4TEhX?=
 =?utf-8?B?bFFOTzllYjh5NHBFRmcxMnpuVCtPQnhjUFNYaWc1a2JORjd3Q2xqUXo1TTRJ?=
 =?utf-8?B?MjhTT0RSRjlydzEySUlSelBQWWt5OGtRU2VXN3JqMkhFUkFDZUxSdjFiRGdT?=
 =?utf-8?B?RGtESzJWY3UrY0Y2SkZWcHQ2Q2F1VDFodkNQQ0RpcjBhRGZpN0luRTRYTUtT?=
 =?utf-8?B?T0t4ZytDUzd2S3RvNk1FR0d2S29HNmFxNysrblF0NGVJQmNhT09IVFRXbzg4?=
 =?utf-8?B?dUN2VlRLUnJYaVVOK0Y3bmVOQ1A4dHZMOXc0bkIrbi9mcXFKaXBGeFEyck1F?=
 =?utf-8?B?NGM2NXFZQ2t4eWVsTGZFMHFweElZUC90NTBjajhXVGkrNDY0eXBkcVpGOWZr?=
 =?utf-8?B?dlVLdUpuMnpWbmtVVHN4ZXJUbERVUjNNRmovZkJmejM0TjUwM3FFUEJCcHBG?=
 =?utf-8?B?THNxN3UzS1pveEpTN0JZbzhXNUdud3JQZDRGVGpwcC9UUzcxL2JyZm9DbUpH?=
 =?utf-8?B?c1dGSUJhTk5WME5CUWNyTVNKSXluYmJsWTRMdnBGYldGclJScVEwaW1MLzBu?=
 =?utf-8?B?dmZ3RWdyQjRJQ0pOeW5ZZzBYV3BSK0FLcWUyNGVnV3NhQklSUTFUVGpxcnJ4?=
 =?utf-8?B?b2pCZCsrUlZjMHN3ZVdXd3ZXUEY2Nlc3MGJNaG1oYTQ4QnZLVFhmbjZkNCs0?=
 =?utf-8?B?bWpkaUgwNFcySE04MjZXbmlhN1VmK1AvQmQxM1FKM2pLOUlnLzVqTTZINzgx?=
 =?utf-8?B?SnVOR0hhcG1MVWhMYnJITy9zcTMxczNZUGxoQjZXQm53T1NoUzVBR1Q3cTBm?=
 =?utf-8?B?aG1jR0d4SE5tVlJZaDIzRHZudGgzQU4rK0RqVlVKckoyNlE0L1EyenFXTWNX?=
 =?utf-8?B?QWFoWVJnRGIxdC9XWjVNMzc2cDBBQTd5UjhjSEhhaWp6YTQ5VkQrUDFySHkw?=
 =?utf-8?B?YnFYYkRJbzZZeUFDT01HMkNKaDdwOXVDQVJiWFFLbml3V3NQcUFPb0ZiMDJP?=
 =?utf-8?B?VW5ZTlZXZlNuMjgxVWtYczNMclJ1OFZ3Q2U2MjZUNVVXL2xaZThrc1lqaVYz?=
 =?utf-8?B?OW41NkJGSjhqSHdlVTQ3L2x3SkN5eWtOTU9KYzg0cHlVS21CeWx1R2hHcWZP?=
 =?utf-8?B?N3VLYnE1OWI3Y1ZoSlZsbjI1cXRxY1pweGx0MGc5enFyK250cThlMXpSRVp0?=
 =?utf-8?B?elFiWVl3NVVqUkFtVHFESWhLOVQyeDZUeTZOOHYxU1BCdmRMVitPelh1T2ps?=
 =?utf-8?B?ZEpCcjZYQWQ1U1V1RmZLZjRKaHhHMzJZeDRlU2NqNU1ZQ1VTOWpvNWNZNHM3?=
 =?utf-8?B?YVREREp4YWFHTjdaWlM2Sks0ODloMTBmR1dUdzRueXlDVnRRd3c4Zm4rVVZv?=
 =?utf-8?B?dXFqSTU4aENyRHZMNkVGRjdyRnl2RldmM1JKZUoyNUx5S2NFN3Bmb2p1QWFR?=
 =?utf-8?B?ZzgwWFo2Z014ZDFtaXBrRmJWRGtnUnpFZzdsNFJqZmtuaDZiaEZUZ1k0MUx0?=
 =?utf-8?Q?HXiNrlC3wprtw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QngxaFNCNWlRQ3pMTmZodWg3aHdnNlVNdXRqeFNkSktURGM3MWVqSHJzbC8v?=
 =?utf-8?B?UEdKQndlRkxoem12Yi95YmlBVy9KQnBnWENjOHliT0UySGRYVXBlWUQ3NDJG?=
 =?utf-8?B?WjFhUEJsSEhzbUREOFJqcG51QUNHTlZCR01jUlFnaFlpQlBSQmhUSE14d0tj?=
 =?utf-8?B?cHNMNU9ReVBqZnBIZGF0YlVKVWRERWoySFZtenlIZjlEMmdYcForbW5vZ1Vq?=
 =?utf-8?B?QmhqR2RoNWgvOUtHSnF3cTVzYkg1eFZZVFRCc1JUZmxqbnFNSGluK3NRUFlm?=
 =?utf-8?B?L29kWVovcVkzOXlQb2NodCtDdjhCRU5vMXZ1UzdSVXlVUEloUXI0UmVDRmNE?=
 =?utf-8?B?Y29SVHBvUDJCTEhjQUQ3a0EzS0JPTFd4Q1RZaHJncmJnZDBjcVBMaCt2Y05l?=
 =?utf-8?B?ZDZDYUFPUDVTbzBSM2NKRDRnUnFCVVNGdmxKeVdGOEJhRVg4cE1GVnNjVzdj?=
 =?utf-8?B?ZkxhL0w2M3JSYUNxbHlIMGNTOWk2RWMyUWdLODU1aWVyc29PZkw0MDBZK0h2?=
 =?utf-8?B?UkxETHRWbVJITHZRYXlsbmFzSjBYOXE5M2h4emxTVmNBNGloYmlDRytpN0Ns?=
 =?utf-8?B?dTlqcFAydVdzWlZkZ3NWSWJqWUh5WXVPUjlub3lvMG5RbjhSdkZFMFB1NWpo?=
 =?utf-8?B?YUhidE1UZmxZaklRSmlaSFpqanh6OGR5VzRJelBSS1NRV1pmKzVGVEVsZVRS?=
 =?utf-8?B?OWJacVNVMmxyZ3NsQllpbGZTUys5QmZBMWo3aFhHQU1vN2xqS3VMV2lZQ2Uz?=
 =?utf-8?B?amRXOUFVMjZKREtLNVpTcER4VG9HbkhZcEVrKzREQm9CRDF4VFdkM0paNERY?=
 =?utf-8?B?bHdZaGY1QW1BbXoybXY3bUZvT2NHQTc1RmhiWFNqeUFLOHFZUC9rVGo3ZXpK?=
 =?utf-8?B?eXRuWHVEcmdjM0U0MmJnTExlZGJ4TWRZbzM5eE93aDVSbFp0OUJRcmFGYUc4?=
 =?utf-8?B?SE05cmc5dzVPeTZyak1vdUxKL21rUTBaS3BHNGsrTVk3NStlTkFzQTBkWlBh?=
 =?utf-8?B?TEE4VTlvdXhreURXbmFERVZuRlkvQ0VpRzlJSW9aakdiREkzNXFSNTFGV091?=
 =?utf-8?B?VUR2REFjNnR2S2l6V3QrUTdLUWN3ZFgyMU5ueDhKQlZTTEp4S2Vvc1hzUHBn?=
 =?utf-8?B?N3FTMzRsUW9KM3hCUXVsWTZRbFJzU0J3QW90aS9JRG9nc2xCbXI2d0d5ZVZH?=
 =?utf-8?B?bDZVVUpHU2VGT2RLNmRjblBidyszY1UrSmpZL0dBZHdQbnhWcExFbHRra2Jp?=
 =?utf-8?B?cERiOXpxN1FoSkhDWFREd3FZN1NuZ0taeE1LV3ZDMTBrYjFhNHlmNWNTd1RG?=
 =?utf-8?B?S1ROOWxKbXdEb29QZ0RlV0FJUnNxMW9CNER3UXRwVTJudWlZZkVFMHkzMWE0?=
 =?utf-8?B?VUE4VVlMOEx5SmVETW5mQ3MyWi9TVER3cXc2a3NUUjZKNCtPY2I4aWUwUHFN?=
 =?utf-8?B?SG96RUVDTDhUK0pDSWJRWDRsNkdwYW93c3NwZ2lYZ3hwRmRmeEtqUDhvVjZ4?=
 =?utf-8?B?WCtmeXBpdjVCT3Q3dWV4RUdlSTZKZ3l6MFduY21GTDM0aHBZVnh5ZFBvZmZo?=
 =?utf-8?B?S1h0a2NhQWZhL3NkZFdyRi8zdEVmaGh4Q0N1QTE1TVMxbURtRkF3bnZPQWZw?=
 =?utf-8?B?Ylhpa0xuWC9LcHg0ZE5GMlBmLzNKeFVtV21UY0FDc2tEeU1VejV3b201Lzh2?=
 =?utf-8?B?Q3prbm1hRVdCdW5CUzJRR0pXeWp1K0RhdDhGQ2FIcENNZStSQTNGaVd6Zlpr?=
 =?utf-8?B?R0NPVHJ0ZW5INjZFd2pZM0hkbUw2SHBjR3N6M0tvdWhkS0FlcUdBRHZIRDlI?=
 =?utf-8?B?eHZqanVMMnBaY29mQXNaNDRqazM0NkIzYVRnalRDdThTWDlsb0NveE5hNUdD?=
 =?utf-8?B?TTdxM29JZlNUOFhZQXpaamJXWkJBbDVPMFlqK1JkcDVOSi9vZm5HcmwyL3hs?=
 =?utf-8?B?bHZVMHRkejFieHJSZSt3WjRBZmJHSnhMbTByVE0zU1djREJ5YzBXQTRrdkF4?=
 =?utf-8?B?anlwYkh4c3ZjMWkwRCtqODcwMUZPcDVta0ltQXpZWGJGSmtWNjZYYWkxRWdz?=
 =?utf-8?B?VEN3dU1mUHlLMkFkY0FrSmNSK3hteXBRWm4rNDVKSE41dlNVYnJEZGlnN1pQ?=
 =?utf-8?B?TWNwRTBmbHFzM0JxL0VYVjZlVy9JQlRFMU5ocVI4cUhMU293N20wZXR4dkhK?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9351256FC59C449FF47799FFAF258C@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b04172b-47e0-4b44-6f46-08dd0585e8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 14:58:05.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99AS7M5TuXAwNgikoWWUF03oE/nFoHRMmDkcydHUZB46hKT7dB/yuV6016ATqvkYMbcL+8NsIj/wZCtPEIakOcwtwdqNXikV80w+eUv5zgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9551
X-Proofpoint-ORIG-GUID: nrFLLLLR5UhliWndXr5OJI_nGP4MK2NS
X-Proofpoint-GUID: nrFLLLLR5UhliWndXr5OJI_nGP4MK2NS
X-Authority-Analysis: v=2.4 cv=YMvNygGx c=1 sm=1 tr=0 ts=67376184 cx=c_pps a=RRW9qgVLUv3Tpt3ACdNssw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=kyCKHByJ1a8aZH7JJG4A:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

QWRkIE1BSU5UQUlORVJTIGVudHJ5IGZvciBCbGFpemUgU29DIHBsYXRmb3JtIHdpdGggYSBsaXN0
IG9mDQptYWludGFpbmVycy4NCg0KU2lnbmVkLW9mZi1ieTogTmlrb2xhb3MgUGFzYWxvdWtvcyA8
bmlrb2xhb3MucGFzYWxvdWtvc0BibGFpemUuY29tPg0KLS0tDQogTUFJTlRBSU5FUlMgfCA5ICsr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCmluZGV4IDI3M2E4NDQ4M2I3NDU0M2I1MTBkZTdi
MDg4MDRiYmQxZjY1MTQzNTguLjQzODQ2YTIzZjlkOTkwYWU5ZmUwNjZlNjVlZDJiZGQzNjM3NmUz
MjcgMTAwNjQ0DQotLS0gYS9NQUlOVEFJTkVSUw0KKysrIGIvTUFJTlRBSU5FUlMNCkBAIC0yMjM4
LDYgKzIyMzgsMTUgQEAgRjoJYXJjaC9hcm02NC9ib290L2R0cy9iaXRtYWluLw0KIEY6CWRyaXZl
cnMvY2xrL2Nsay1ibTE4ODAuYw0KIEY6CWRyaXZlcnMvcGluY3RybC9waW5jdHJsLWJtMTg4MC5j
DQogDQorQVJNL0JMQUlaRSBBUkNISVRFQ1RVUkUNCitNOglKYW1lcyBDb3dnaWxsIDxqYW1lcy5j
b3dnaWxsQGJsYWl6ZS5jb20+DQorTToJTWF0dCBSZWRmZWFybiA8bWF0dC5yZWRmZWFybkBibGFp
emUuY29tPg0KK006CU5laWwgSm9uZXMgPG5laWwuam9uZXNAYmxhaXplLmNvbT4NCitNOglOaWtv
bGFvcyBQYXNhbG91a29zIDxuaWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQorUzoJTWFp
bnRhaW5lZA0KK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYmxhaXpl
LnlhbWwNCitGOglhcmNoL2FybTY0L2Jvb3QvZHRzL2JsYWl6ZS8NCisNCiBBUk0vQ0FMWEVEQSBI
SUdIQkFOSyBBUkNISVRFQ1RVUkUNCiBNOglBbmRyZSBQcnp5d2FyYSA8YW5kcmUucHJ6eXdhcmFA
YXJtLmNvbT4NCiBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVy
YXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQ0KDQotLSANCjIuNDMuMA0KDQo=


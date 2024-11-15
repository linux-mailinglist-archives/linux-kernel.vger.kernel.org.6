Return-Path: <linux-kernel+bounces-410896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0049CEFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1092F1F213AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960871D63EF;
	Fri, 15 Nov 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="Ni9vyxHM"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460A1D515E;
	Fri, 15 Nov 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684513; cv=fail; b=hCtV69eNhmG2vok2s2LUkeF8PjHlcagCq2TvstgOkLWZEpTKjqIQGtJUTA+juBl9vbszt2jFJ1k8lcF6CVGebXWipSMQQ5RjudJv4HvaNYiN6jCbLEXo3Ir2FXWpZCv2VL09Ip1dTBFpkRV0S5PlnF9zNAiGjxUnjM9y14pOva8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684513; c=relaxed/simple;
	bh=ycmfea1C8JYesiBAApbk5ycSmRf3sKv9hNoPNCVYHwU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JZiZDtx0Mac/zrqU/gS/Xi2dco/fyCMQOv58H20m0FSnvfWRgdQnCTynMKzbIUTjbdOjJWx8s5FiIyCvTD4mudPRiIlErNLcHTUU64+9K5hdiJYQch+9MfN3iZxrVRoOssbzpvOO0SWJNV/yms6fTExVtvdtAjgg1AJBujm9rc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=Ni9vyxHM; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEpvmT003841;
	Fri, 15 Nov 2024 14:58:05 GMT
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011024.outbound.protection.outlook.com [40.93.132.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42uwr1sv90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 14:58:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+RxbMY+J0S7sVNmv7S9W7sqDG9OooMfxRvzzUhF/ZRF7LNxURNGGj+lmvcgKKUSjwEKYlA1W7Ct+tzIa/f/8empcCL+/AW8YbgVqGp3HrJpNogUuftqRlmUU7jfLibhQlbmzwqdp83RaVFzsAjBQxohAhF36V/Pv3+UtqetY5JqxIz/+ntrMDGpBpeXeSC15t0EwGlxK85lEfs71Xmy5UQZcz3hQDu0mA0eNgU+Zko9xD99nKhamiBXT146DYXpYkaY3ffO+NZK1kXAq+D3YoDs28ioT4J8rM5Dpt+ZLOM9gJUECtTTqdy9vGLcNq6B8N7oa+1IrzEoQueF73pUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycmfea1C8JYesiBAApbk5ycSmRf3sKv9hNoPNCVYHwU=;
 b=MJ/uA1yR/v2rJkPGIF9GfwUBx2rFcswqJKtdbcjnP2/ONnaQY5oC3vYGcvdDh4l3orG+0brFYSD7DjJsVwET4XL4qN7uEqSSiUfbsayvzRjjsFjLefFGBPprHwEWV5IT7bzztDELN3CbZAV6hqXZyc1ILKOQG72CnoNsU4JoPXOZ5baUDALMlCW4PDa+OCISpOQLEWRrkX42jjD5S+KV68s75G/XoNN8HJDdGcDqA5bIpuBmiLSzD41mJq8vFLES187Uuvyrt8/x6PLKhyHQU4zMQ2eTC9ROo+5zFI7Rn5nJOKcICWtN2sBlsxrGCVN44bbHsU4sW/3YejzmlNgNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycmfea1C8JYesiBAApbk5ycSmRf3sKv9hNoPNCVYHwU=;
 b=Ni9vyxHM1GDXvS/GW64h4UIjXcB+Tpgf9QIpaJ2U3P/ohf1t2nsr4xvihV20pZnvBNakBLMiy2pBuV4h6KAopCDZOI5ADnZTVHIS6KGuFwFWYm314fopvhLkxM8TA/NJ+PUVXoEQ+s8Ql9iL+Z6MEzzeMJl6v+THP6sFeIqaifM=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB9551.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:58:01 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:58:00 +0000
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
Subject: [PATCH v5 0/6] Add support for Blaize BLZP1600 SoC
Thread-Topic: [PATCH v5 0/6] Add support for Blaize BLZP1600 SoC
Thread-Index: AQHbN27D0SZ9usa/hEiVoIvN3WvsXQ==
Date: Fri, 15 Nov 2024 14:58:00 +0000
Message-ID:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN3PR01MB9551:EE_
x-ms-office365-filtering-correlation-id: b8e0537b-283c-4250-84fc-08dd0585e632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2d2bHo0V1NaaWdiU3BUTzhzTkdTcW5pY2J0RzBYVmY2Y1RpWkhoZTJWY0pV?=
 =?utf-8?B?TWVwazJINHg5eXFWNllCWmdvQ1lwRjRTQ2VOcm9OdHRveWFWMUpSRWh0dThn?=
 =?utf-8?B?QlZEUUVCRTYrWndUaDZtenVyVGJaSmdFcWNpaWE1dFFCSnJNTVFRYmd6Y21m?=
 =?utf-8?B?bmZWZjN2a2taSTU3ek00TGVrZVFoVEJpRDVkam5UeHJCa1dTRFhjNGdjYUpp?=
 =?utf-8?B?WEJDY1FJZnJEVlN2V2xNd2hDUEdQRnBRVm9aaVhFenZlTEl1WlRnN1dQc1FP?=
 =?utf-8?B?eG5vTWJuRS9KeERSM1VocUszeTVFRUt3aEhueTdFUzMwa0FUVy9xMDJrNjUw?=
 =?utf-8?B?WWQ3WW1RaTJKUU5ZZzJKV21MeFk5dW1yaWwrWVBkZGtwNTVxNXJ4WlNWYVIr?=
 =?utf-8?B?cURzYVNtK0ppWEpseEpNRU9NbFBBV1NJK240UUVOQjZGeU9kZjh1am90NEU3?=
 =?utf-8?B?d1ZQNjFhN29OSGVUemRyUDk3RWtZSDlhZzZvMmk5cGZzU2FaRXJSL0djSzBL?=
 =?utf-8?B?ZGtFd1NoMVZ4K1lFL0h4VVREMFp6L3lhczFYWUxIZmRNbHBycnJlcFB0OTdt?=
 =?utf-8?B?T3QzTXN2WVdsY3dXSXNpZ0RMQzFaUzJRYlFFdnRlK2R2a2xNSGlCWEJuTm00?=
 =?utf-8?B?VGpQNlYwOXZMVThHSFVJTmFacDJ6WXNUdkVBWlkvTitqa1hmUmdqUE80NTRJ?=
 =?utf-8?B?anJ1OEo4d0NuSVk3MWw0N2lhWXEvSW14OWtFZE9rekJGVEFWSkNyRTRRSDdi?=
 =?utf-8?B?VllCY1QzOUR6Vi9IUS8zZHpkL2tzOHMrUGRma1ZIVjZ5QUY4TW8ySlR5aUlO?=
 =?utf-8?B?TXE0MEkzNTdISCtzTDZHNUdsVFF0MGx5ZFd6TmIwUERvY1Vva2w0NVlNSWI3?=
 =?utf-8?B?WXJPMkw5NzRwblpnOEZSUkcvRnNrbXg1eWxWeCtXemJ3UCs2a0JuR0djcENs?=
 =?utf-8?B?c3IvcVM4Z1dyL244cVZwOFIwMGRHUGoyUUJLTUF5U0dVU0ZwQS9IVGkyNkZ2?=
 =?utf-8?B?TDMrUTk3bmRGSm9hYmJFTmN2SU00N0Q2OTRjR3RITGhyRUZ5QUNsYnYxQjNB?=
 =?utf-8?B?ZXY4YnFsSXdiTjlZcVNZU2NMZkR2SjFGMVJKR3Ezc2FLMHR5cTh4d2RJVVM1?=
 =?utf-8?B?OWduTm9iemFOV2FNR2hJOG5YRWl0Z1hoN3hMbXhxdDRuTXBZTFhCc0l0OEQ4?=
 =?utf-8?B?bnIwRC82V1dRc1NHYzFjYU9XWWEwMUpWdUR6SEkydzdUZFRxTGtQYWg1Wkw3?=
 =?utf-8?B?elV1ZUpUYmJpZzVjaUN0N1JFWUVXRzB3eEFJenBUb0xMZDYycklSZEdpYThw?=
 =?utf-8?B?NW8zWFltV25PcTNHL1lFaUZFWEJxWFRRMllFY2RQSm9vZ3c0RHFWemRnMlBY?=
 =?utf-8?B?cDhCcUJHK2VaTE9Wd2RraWUyWUJVdlY0bmZLNVpNSEsvR0R2L1FGb0xKZ1JQ?=
 =?utf-8?B?Vk5SZDErZWtwdUV6aTVNemY4T2NieHNzajZ0L0VDcjBtZnhWQWc0L20rVmNk?=
 =?utf-8?B?c0hwd0VHMW0xbmRsQTI3SG5KWG9POTIyYUp3T1VRdzM3Sm11dmUzdkw5RHdL?=
 =?utf-8?B?U1l4WmZ0Nk9VN3Y3UlU5dVRiM0o3Mm9MOS9yTUxWTUNJbE44N2dkeFI3Smwr?=
 =?utf-8?B?cG1nR3VjSFhOSHBiUTRGdWlMQStRdSt2NFR0QzNDd0RmVXVVTWRxZDRjS2pZ?=
 =?utf-8?B?Q2JHYXhIeFV0WkpEV2d4UnFPNDViMEpMWUIvRGJEWW05UE5ab0NlSGUzaXp5?=
 =?utf-8?B?Nm5CUllUbURWekRBRTl0VEw2RWIwbXNaUnNJMzIveWJWdHRqRVZwTVROaTEv?=
 =?utf-8?B?dUZkZ2NlSUxrQXFwc01ZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDNDSXhIc3pKOVFpZW9sVEpFQU1BUzhBeHJKSjdYZStFNjlIMWh1eUpTNWN4?=
 =?utf-8?B?Zk5HNkt1cStSSlpBK0JYVWc2anplbUYvcWRyMCtaWXFraE5TOGpUR2hvd2Er?=
 =?utf-8?B?bUhXREMxQVkvVmNCM0FlMVNoWWoxUDZ3V21SMTAwaGYybEJhWVN0UGx1UzI5?=
 =?utf-8?B?eFhuUDRJeFRQeGszc0lUUkxRaEk2TUlDUFJ1QVJKNURYeGxZM1RiUEp3YlU0?=
 =?utf-8?B?VHR5eFF0K0s5TVNHZU9nN0xQY1pKZ0p5WmtESmVuZ09NNUpMYTVaaWczWVZq?=
 =?utf-8?B?dTJsZGVmaFhaNzBqN2NGbFIrdG9aalFDZXQ4TkFJZU9OVzZDeWRWTlFDOGY0?=
 =?utf-8?B?Mk5QeVhqTWJKb3lmeVU3VituLy9aREs1UURKK3FaSU9neTZKdEJCWjdob2lw?=
 =?utf-8?B?MUhyT1B2SzVZbE5VbE02K3U4aFdHajU2R1kyWGZ5NjRyTzVaVUJoMTF4bXpq?=
 =?utf-8?B?WXRmSmdUKzZIcElMNGEvMTVCRDlOQnpwMXdwTTBPajlyMW1hM0MxTG9NYlpJ?=
 =?utf-8?B?ZFJSeHE2KzFZeHprYXF6Z3RhRFJxdXFVSXlISGVNMURBQXIzRjYrMVBYY1Bt?=
 =?utf-8?B?NGhZd1hnaWJqZ09XLzg3SHpNKzdjbmV2TGtoTURnUE1uVTcxelY4RGNYR3JG?=
 =?utf-8?B?S1NOUGtVa09qREpvUi9HL3FyR0FTZmg1NjYzNUdYOUhOVlhnU1JUNkg2Mm9B?=
 =?utf-8?B?Q0hMM0NlNDd5K0l0WFBvRlBsMnBXc2VlbUV0MjJYbUpZS1lYVDlVdUdsMFN6?=
 =?utf-8?B?VmtITGFrdDlEUmF1ck1kQzY2VGhjZHBsRjU2MDdWQUduQklEdDNCOE9xaVpn?=
 =?utf-8?B?RGUraEpoWEZBS09RQUd6TFFqZE1HMm9IQlg4MHlQQjRJMThhVnR1THlmYStB?=
 =?utf-8?B?VTVFc0Rza1JNeWlvUGpXaWlXbXg4TmJEUGFNYVFHOVpsTUswSkZFOG1DWEF6?=
 =?utf-8?B?SHo3VnpHUjhDMTEwZDRKNUdRZnh2WFdkUExmVXlyeG9xWTZvWXBGcHJ1WXRV?=
 =?utf-8?B?SnA3RzBTTVJnVlZKYnliWE5DUnJTbE5jNTdZSmhyYk1VS1l4T0R0cDNrVW8z?=
 =?utf-8?B?U28ySTZtaFZiSHBodUhWeCtuTjVzUllZTUIrQzE0clNBc1Q0emwvWnZoSFVG?=
 =?utf-8?B?enlxc1M5eEkvUWthUkI0MUhJNDVocm9GODRvdjAwUW5iUCtZMTJuWDdlckFR?=
 =?utf-8?B?UVM1WFU3MDRpQnRBS09xTUVWRW1sdzdnbGtpTUtGcFVsZjErVGFiTzI2MHkz?=
 =?utf-8?B?Kzdlc2p2NHRmNDhUc3A0SmxySU5QT0o4SEJEV1hORWxnLzEzcVcrNW43aGVw?=
 =?utf-8?B?RVZNWFR4UEY2TjJyYVZwVWk0UTNBeDFUeVEyeHRzeG4yN2dpYnBVbW1pZWc0?=
 =?utf-8?B?c0xuMlVSalJCaFgyZ1FHdFZ4K0l4bmExd1VjSitkaEgzQkVQQUgwWVB6b3BZ?=
 =?utf-8?B?NmdDNjRXekRrTlBCby9USlM4MksyWWJid0dtck5UQUtQYjFyOXVGbnBBd2VD?=
 =?utf-8?B?bk5ndExjSWlJSU8zZlBmenFQNXFkVmI0RXVxT2NoZnpmTklYL01tSmw1elps?=
 =?utf-8?B?eml4bm1HREk3QkFZd3BaN0h3cW44VTNZbG9ZY1hTV0RTd3NaU251YnpvNW1W?=
 =?utf-8?B?YzlobXhLS3cySllOVCtLQmRVMERMRG5yMmF2VTY1NWFJdk54TmwzM09CUUN6?=
 =?utf-8?B?MEoybnNiVHpzQ1ZEbTZyMXlMcitKUmZ1bis1YXQrdGs2QzVuWnFDM3g0eFhz?=
 =?utf-8?B?Y2owdDVwL3Jxd3pQZmdnaFVZcXZoaW9jSmFwQWNFWEdvdmU5d05ab28yazJr?=
 =?utf-8?B?U0hyMVNzZkhCa3FYd01aenkvdTR0VEpsUDBENFJ6bXdzYnFKZmtQa3JqUWM0?=
 =?utf-8?B?TmVEUWdtZ3hOYkgrcHF1UnBuUjRZWmcrc2xuT1Q3T244dSs3ckpjYkQ0UnRx?=
 =?utf-8?B?aVZuWHZpallJVEJTckdXVGhYNFUvaERxaks3MXJqd0ZvTzc4RzFERkdYcXZU?=
 =?utf-8?B?dzI4MDdiL2pSaTVSK2pZbFR6UEl5a0tyc0FhaFAvL1c1RVdUeEJlcGZYRGJ6?=
 =?utf-8?B?VHpjTE5mMDE5VVFzQ1JSZC91VkE0ekpmYWVKUzZNSGkvWFFOSm1uQXQ3M3dV?=
 =?utf-8?B?N05YZHNndXljREU4R09XUWYyTVBhQjRoK2hQMG9xTjBMOXRYV25oMEgvTlAy?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B02639B1329FB04CAB17EB1AD190FCD7@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e0537b-283c-4250-84fc-08dd0585e632
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 14:58:00.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLan0cD8HI/9yn5A7u7lrZS5b/3Vqz4Vwkm0fqu0C3upfwzPoFSvKzMleAf86G+qOmPUMXY86Kom5yHuiID8kggnppZSmVqBr0fcdBG85eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9551
X-Proofpoint-ORIG-GUID: 8bONnGHoFlhOdqi9Lep0HSz5vf7b4lAI
X-Proofpoint-GUID: 8bONnGHoFlhOdqi9Lep0HSz5vf7b4lAI
X-Authority-Analysis: v=2.4 cv=YMvNygGx c=1 sm=1 tr=0 ts=6737617d cx=c_pps a=RRW9qgVLUv3Tpt3ACdNssw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=4NF1JnvJtH-ECglWYFkA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

QmxhaXplLCBJbmMuICh3d3cuYmxhaXplLmNvbSkgaXMgYSBTb0MgZGVzaWduZXIgYW5kIG1hbnVm
YWN0dXJlcg0Kd2l0aCBpbnRlZ3JhdGVkIHByb2dyYW1tYWJsZSBHcmFwaC1TdHJlYW1pbmctUHJv
Y2Vzc29ycyBmb3IgQUkNCmFuZCBNTC4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUg
QmxhaXplIEJMWlAxNjAwIFNvQy4NCg0KVGhlIFNvQyBjYW4gcnVuIGFzIGVpdGhlciBhIFBDSWUg
YmFzZWQgYWNjZWxlcmF0b3IgaW4gYSBob3N0DQpzeXN0ZW0sIG9yIGFzIGEgc3RhbmQgYWxvbmUg
U29DIHJ1bm5pbmcgTGludXggb24gaXRzIGludGVncmF0ZWQNCmR1YWwgY29yZSBBUk0gQ29ydGV4
IEE1MyBjbHVzdGVyLg0KDQpUaGUgU29DIGluY2x1ZGVzIGEgc3VpdGUgb2YgcGVyaXBoZXJhbHMs
IHN1cHBvcnQgZm9yIHdoaWNoIHdpbGwNCmJlIGFkZGVkIGxhdGVyLg0KDQpUaGlzIGZpcnN0IHNl
cmllcyBpcyBqdXN0IHRoZSBiYXNpY3MgdG8gZ2V0IHRoZSB1cHN0cmVhbQ0Ka2VybmVsIHRvIGJv
b3Qgd2l0aCBhIFVBUlQgY29uc29sZSBhbmQgQVJNIFNDTUkgYmFzZWQNCmNsb2NrcyBhbmQgcmVz
ZXRzLg0KDQpWNSBjaGFuZ2VzOg0KICogQWRkIG1vcmUgaW5mb3JtYXRpb24gb24gcGF0Y2hlcyBh
bmQgb24gZmlsZXMNCiAqIFJlbmFtZSBhcmNoIHRvIEFSQ0hfQkxBSVpFDQoNClY0IGNoYW5nZXM6
DQogKiBBZGQgbWFpbnRhaW5lciBmb3IgYmxhaXplIGluIGFybTY0IGR0cw0KICogRml4IEJsYWl6
ZSBzY2hlbWEgJiBkdHMgY29kZSBzdHlsZQ0KICogQWRkIHJhbmdlIGFuZCByZXNlcnZlZC1tZW1v
cnkgYXMgc3VnZ2VzdGVkDQoNClYzIGNoYW5nZXM6DQogKiBSZW1vdmVkIHVubmVjZXNzYXJ5IGR0
LWJpbmRpbmdzDQogKiBVcGRhdGUgU29Ccw0KDQpWMiBjaGFuZ2VzOg0KICogVXBkYXRlIFNvQnMN
CiAqIGBtYWtlIGR0YnNfY2hlY2tgIGhhcyBubyB3YXJuaW5ncw0KICogRml4IGR0cyBuYW1lcyBh
bmQgcmVtb3ZlZCBkZWFkIGNvZGUNCiAqIERUUyBpcyBzZXBhcmF0ZWQgZnJvbSBhbnl0aGluZyBl
bHNlDQoNClNpZ25lZC1vZmYtYnk6IE5pa29sYW9zIFBhc2Fsb3Vrb3MgPG5pa29sYW9zLnBhc2Fs
b3Vrb3NAYmxhaXplLmNvbT4NCi0tLQ0KTmlrb2xhb3MgUGFzYWxvdWtvcyAoNik6DQogICAgICBk
dC1iaW5kaW5nczogQWRkIEJsYWl6ZSB2ZW5kb3IgcHJlZml4DQogICAgICBkdC1iaW5kaW5nczog
YXJtOiBibGFpemU6IEFkZCBCbGFpemUgQkxaUDE2MDAgU29DDQogICAgICBhcm02NDogQWRkIEJs
YWl6ZSBCTFpQMTYwMCBTb0MgZmFtaWx5DQogICAgICBhcm02NDogQWRkIGluaXRpYWwgc3VwcG9y
dCBmb3IgQmxhaXplIEJMWlAxNjAwIENCMg0KICAgICAgYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxl
IEJsYWl6ZSBCTFpQMTYwMCBwbGF0Zm9ybQ0KICAgICAgTUFJTlRBSU5FUjogQWRkIGVudHJ5IGZv
ciBCbGFpemUgU29DDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Js
YWl6ZS55YW1sICB8ICA0MCArKysrDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXBy
ZWZpeGVzLnlhbWwgICAgICAgfCAgIDIgKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBhcmNoL2FybTY0L0tjb25maWcucGxhdGZv
cm1zICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQogYXJjaC9hcm02NC9ib290L2R0cy9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvYmxhaXplL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAyICsNCiBhcmNoL2FybTY0L2Jv
b3QvZHRzL2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAtY2IyLmR0cyB8ICA4MyArKysrKysrKysNCiAu
Li4vYXJtNjQvYm9vdC9kdHMvYmxhaXplL2JsYWl6ZS1ibHpwMTYwMC1zb20uZHRzaSB8ICAyMyAr
KysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAuZHRzaSAgICB8
IDIwNSArKysrKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmln
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogMTAgZmlsZXMgY2hhbmdlZCwgMzcxIGlu
c2VydGlvbnMoKykNCi0tLQ0KYmFzZS1jb21taXQ6IDgzZDY3YzI1N2Y0ZDA0NWZmNDc3MzA5YjU2
MTdkOTMxZjlhN2JlNjYNCmNoYW5nZS1pZDogMjAyNDExMTEtYmxhaXplLWJsenAxNjAwX2luaXRf
Ym9hcmRfc3VwcG9ydC0xMTI4MTk0Y2E5NzYNCg0KQmVzdCByZWdhcmRzLA0KLS0gDQpOaWtvbGFv
cyBQYXNhbG91a29zIDxuaWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQoNCg==


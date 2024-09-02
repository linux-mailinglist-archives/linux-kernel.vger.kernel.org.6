Return-Path: <linux-kernel+bounces-310782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094996812A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1571F21825
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4917C9A4;
	Mon,  2 Sep 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="VJ8IkBVT";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="Lp5kKocb"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1385176FB0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263993; cv=fail; b=qUldl5T4hGafhBmDIH0Fpz/JwJWrbmPBDSQH6Sv4S78xMeWBjTdkhtWMdaoxJAbN4l8YjlqjJWrd9jXmm+S7fdDlydANJg532PrDkCB2DkVlIPwzSUSwqnT2iuHBi6YeScJzOkYuF3BMaweCS4ihcFuUAV4zjyQYU8wwQC6dlOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263993; c=relaxed/simple;
	bh=5AXLluNEdPWFiHZl93mgbKDsGtxKposi0QqTzNRBUws=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OS7y/4rnzKhxD0bq2pv0RBWjq0MM0rXQYOTBobeFl17etIxURMYptqQ9HZEX5fdwfry9lUHuMEytD8lRJGO+Gfwc17x5yb/xSAw5hBFv5osmMUbOHobsCDKS1iEnGzdO40BK20cQ2dlGKmZCnQIX3/WV5KqXbzYZOQAvYeTrX3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=VJ8IkBVT; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=Lp5kKocb; arc=fail smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4826emti019230;
	Mon, 2 Sep 2024 08:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=5AXLluNEdPWFiHZl93mgbKDsGtxKposi0QqTzNRBUws=; b=VJ8
	IkBVT6CFWmNHffSvVjdVVtlOtyhKEZfNXxd8xGCWIlibQVepS9ujT03W6Dq1Obup
	Q16+aFmYN0tLYbiLucHcaTWVbqzW3Meuf+Xb3wckdorqf4kb+CUnURg9nw9fK1C3
	EMKENNvyB9r19LPofApkiRyO2WKfd6dt1/G6eULq4RCwKx0grAkOdgRJB3XSFK/1
	JW+jhfrXUuM1TQC2ryd+JaMKteAzSjnugddmcTYjzw+4uVbSboSOUCfUMj3Tj7tT
	d1Bqa1ew+dxQCG7cf3YlUZOCyt3iwj34gv1oMuvEnDPCoFSpPQ1nv2oCzyIKchow
	/JoWebo5wXRCJyTvpNA==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 41bses9b45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Sep 2024 08:59:29 +0100 (BST)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 2 Sep 2024 08:59:28 +0100
Received: from CWXP265CU008.outbound.protection.outlook.com (40.93.68.0) by
 email.imgtec.com (10.100.10.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Mon, 2 Sep 2024 08:59:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnAp1pGbP/MoZX30HiS1QUET3OL5dWlH9+GN2rwMLDgZTmfolGk1D4MwBdEbdwbkxnM/uqo8JmF25Fa626BouiNwIK+NFOedEGv1t1e90o7CFVBufbEcIeHx6KXMJ//L14mZwP3sr7wVIFxlNoFY+N9GbMVKfq6ODDIupgfphFd55L5RDVn1F14t3c4mOc7zVP8inNdxBOdsctYyMoJrjf+LR3X2GZwGC/OKTFrnws6ZOUMiFBhrOVRK2uoqBLq8MhcR+Mxz4/WNseYHV9MscMJ1jJA/NPF8X649hSSn3Oua9Z4rMHsJWlQD3O4GfNvEoQ0G53ONLbgosxsmMbfYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AXLluNEdPWFiHZl93mgbKDsGtxKposi0QqTzNRBUws=;
 b=B1LobWOpoO1RVaPImi3AsBgdqNmCLK1IZFjCa5bVzACkYj9R5+uCH4QBJ16SdYRezVDlw/BkkOKEqjKKywS9mYDOwjuUFaaps7A1LQMQ5SkeX4VOaWgN2Rh+kVTcgHFJerwbeECw8BGiHnK43v4QhaGIeKgMa+sL8FDDJYaKU3HgpR/Hq/K6EOlwHlkN3GWJCfYcLDMcVx3kKUhmtSc+FofRnC1u7FOQU5uxzgTB3pmwoR6LV556JSqK3W+81JWBLLYjlVK4eb9ZJGBvpGW6pLS9O2d54sjBpu6gHnxHtb2HdgcEEBPrZ3wslM7cFgtDig4w5Y5EW0Rejj0sXw7eYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AXLluNEdPWFiHZl93mgbKDsGtxKposi0QqTzNRBUws=;
 b=Lp5kKocbndw2pOanNNLz0JxFFzcaa/O9cf1KclLu+UNJEVX8oAgx2h9Gvpluj6yGJ2MqY+AxLhwDCl2lxMAD0Sv0eULd3KpbtPnDQTENi2dXjAG90z6ilituuWru+uGzhCkZU2BjZtQi/ubb7YTIxXjP6ZKj6HLUQpzTIwmNNNU=
Received: from LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29b::5)
 by LO7P265MB7862.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:411::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:59:27 +0000
Received: from LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM
 ([fe80::53a5:42df:8e94:653]) by LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM
 ([fe80::53a5:42df:8e94:653%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:59:27 +0000
From: Frank Binns <Frank.Binns@imgtec.com>
To: "tzimmermann@suse.de" <tzimmermann@suse.de>,
        Matt Coster
	<Matt.Coster@imgtec.com>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "daniel@ffwll.ch"
	<daniel@ffwll.ch>,
        "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH -next] drm/imagination: Use memdup_user() helper to
 simplify code
Thread-Topic: [PATCH -next] drm/imagination: Use memdup_user() helper to
 simplify code
Thread-Index: AQHa/Q4IAOMgNGfns06tWudby5N50g==
Date: Mon, 2 Sep 2024 07:59:27 +0000
Message-ID: <0e15f5a15a0fd5f21da99aa85fae2517e7d4487f.camel@imgtec.com>
References: <20240831102930.97502-1-ruanjinjie@huawei.com>
In-Reply-To: <20240831102930.97502-1-ruanjinjie@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO4P265MB6026:EE_|LO7P265MB7862:EE_
x-ms-office365-filtering-correlation-id: 65f75a39-1fdb-4beb-a65a-08dccb252ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUNGSVVhR29Yb28ySFQ2UHJxN0lseTFyd0pFNnEyb0Y3NkV3S0hKK2dnRjN3?=
 =?utf-8?B?cjV5KzdjTUhkNzUyOUtUWVNNZThMeEtpV3ZtNWFtakw4REtQN3ovVGdFclpQ?=
 =?utf-8?B?UnBrRXhISUxhUXZLdVhvT2FBQXluQjlIenpGVytJTGZlRGU3WURSUldkZFlI?=
 =?utf-8?B?UnRCN2VZZDBkbCtMd2NraHc1QjdBYXJtMmJWbHhLdGlHeitvNmh3VjBxVnVB?=
 =?utf-8?B?RW03azdFR3FJWXl4d2QxUzNYS0lVV28xcWZmaWQrVjMrNEpGUVA4TEI0eFNB?=
 =?utf-8?B?QStDeExwQ0lkSG9BM1BQTEtLbkJOd1E0NE1qUk5GYUJNMHNnbjdQZTE2U0FE?=
 =?utf-8?B?TFlhR0hKcmZ4TkhZUDZDSkljemJsYTNTT0l0UVNUemg0VzZSOGpKTDR6czFU?=
 =?utf-8?B?c3ZOcmxDU3kxSGwrc25Oc2txZnNRckdaVGY2aGZtYmJsVldyQ0cydFZFOThV?=
 =?utf-8?B?dkFrSDdhV0lvQnJnWVdnN1ZTMFZ4MzFKNENyd1B5dlFoQTAwSFlqa1ZLazhi?=
 =?utf-8?B?aXdueHZqTHM5MWZvTFBBd2FqSklxZlZjVEgzSHBiSWZ6VjJkeWtsMmhDWUk1?=
 =?utf-8?B?cUQ1MzRINDI0bGd2STZKV2V0VzJFZ0tnN1VIRVdqZUdkT003eHlOUG51MWp6?=
 =?utf-8?B?RU84eEo0eS8vZ3c4VXg2K2ROZzhjZU5sYlVLM01ZNTk3c2s2UFQ1QURMalBG?=
 =?utf-8?B?LzV0SUZqcUVIRkV3cGtWVzZ1RUJUa0lnTHRyVWh5Mmd6VytsMThxekFPNzh4?=
 =?utf-8?B?WkMwUVMzZ1JQcEV1eFI0cHJLbFJ3Y01qVmIycFphVmcvWHFVRE13UldWR2NN?=
 =?utf-8?B?RnE5WVhqZW82ZzNaRVNsQVlUWDVMU1R5aWgzQWpRRjlQR3hJUjVKWmtxU0w4?=
 =?utf-8?B?WkZpdnQ3ZENJMXJvdzZLSkVsVTZYeHRWTzl1eTFDQ0FyZW8ySXYwR1FoUmor?=
 =?utf-8?B?aytHaWtqdThIQWN2RHNEMms1KytoK2tRSkcwbmpib2xnY3lXQlFaUWtSUjZ2?=
 =?utf-8?B?dzA2TVl1S0hKa3dqTHhZQk12dnJRajB6MXl3OU9zMGtkQ1FxMFNzTTRxWnVL?=
 =?utf-8?B?SXRtenRwWGJtdzdnZHJzY3ZVd011MkJSQ1ZmTTRCd2kwblh5bGZ0R1FhZ3p1?=
 =?utf-8?B?RmxHYloyUUcyREV0eFQvYVJ0L000bU9kY3lpL0JXeXJYRzlHMjZxZ3N2SCtF?=
 =?utf-8?B?QWgyRHp1T2dweHpKbWdiMVNWazNhbjQzMVE3SUFFaTdtdi9jaDUxQjAyRXBU?=
 =?utf-8?B?ZENCMVhrUlNEMXBjcGkwM0pCa1UwT1Y5MmtUUUJXZkdjem4yT2RKVG81U1gv?=
 =?utf-8?B?K1R6SkptbDlYSjE4MWEvN05mbE1zS3ZmK0E5QjJaeXBIY0FqWTNoUkdrc0hG?=
 =?utf-8?B?R3Q5OFVNMHlUTHdLaEZjYU1xQTU0ZFFMNHhHRDQ4emdrSW8yUTc2aEZRdS9T?=
 =?utf-8?B?ZkxYZGxlaE9Ob09JTlFpRkI2SUEwU3RsTGdDaGl2RXBjRTdZRXJPbUQ1ZjJx?=
 =?utf-8?B?UjhSMGpUQ1ZQdTVIQjZhbWNoSkRzaWFKMExJSmN6cDY5YldkYSt5bkc2UThL?=
 =?utf-8?B?NkU1djB1YXRvd1pmc3VUL1cvdnFhZ3diMGViQm54WGp6aXV3RGxua0xCQ2Vs?=
 =?utf-8?B?NlkzL0YyN0tzZ281UkMyeTdVQkZQTnc0MEljUWpsTjB4ZHI2WHhMWmRFSjZi?=
 =?utf-8?B?NDU3SWdnV1BqOUVwNlBqNzJPSXNVQUNQSzE5Ym9NRmFWMU5lY3A5a0M1eG5m?=
 =?utf-8?B?UDQrZUVxOUkrS2ZvdUJOWVRvcEIzNTVyaU4xWkcwcmxBNnVWV1pRaWpmdnBL?=
 =?utf-8?B?a1g1Tm5JMTl2RjBKejZwb1Ixc2VHYU12M0NkYVlqMXNON0txMTUvMzNVVHoy?=
 =?utf-8?B?ZUtMV25ZN0dIMVYwd2tKQlg5REYraE4xMVBwMWpoRk1jN3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZZRXBRazRxaVRLN2FidHV2TEc4dGk3YkFKMkxoV0hhOXpLWmFyOXUveGpp?=
 =?utf-8?B?dEhOMnpqRzgyZ2NjL1pxZlA3OC82ODNGMUZZejBvUVZGWkZnaEplNDd6RUM4?=
 =?utf-8?B?dHdVOXdCNSt4T2szYThES25TUmRXZyt1L0YrWmNzNkpiUEFtN0dOMVZ6dWlS?=
 =?utf-8?B?TEk1b001UkhSaFZYb2I5QnBOMHpqRTIwTkNOVmdpZTdPZjVYREVGTCtCL2ZL?=
 =?utf-8?B?ZFpSeWtzbTFTemttYTk0enc5OE9aZGNFRGZiUWUxVGg3alJiSk5ObGovTXAv?=
 =?utf-8?B?N3IwQkJrMGpkZCtOZlhTcEhsZ0NpWkc3eEV3YkFkVzRGNkxNcS9YVGk3UjJX?=
 =?utf-8?B?K0RLRkZTQ0ZtV0dyWDlyUWQvL0docGtYb043QXhOU1NHU1FaRDdTSWZ1cEh0?=
 =?utf-8?B?WWxRUU4wOTY3VVRMWnlHczlaZUNpN0F4QUdGczNBN25VNGZZZHhaYStieWZz?=
 =?utf-8?B?T2RObzIyS2FreFNackNxS1pjQWloMCtrSkp6TFoyZlpiSW9uMnNZdk51T3Ry?=
 =?utf-8?B?Nlpsd1lJN2JnemxVTnJIYy9lNUZCdlpTVXdLemlrQmQra0FLNFJPVHZVMEg4?=
 =?utf-8?B?UDZKV25nZ1BKRkxUeEtJdlhHV1R4bHZlN2t5Rm1IRy9KWWZvZDBZNGdIdFFH?=
 =?utf-8?B?bUNtUW16a1hYU2hFeCsxQ2pWM1U4ZzVFS3NUVEkwM00ydG94eS8rVnVWT0tx?=
 =?utf-8?B?bXBOUk53cVByVXo4bkhySWQ1QjQwdnErNXM2L0R2K1ljQ2tMYWcrUllmNnZK?=
 =?utf-8?B?azV3Q0ttY3FGWm1ZbjY3V3VzbXlnaG1aQzMxSFArZ201ak1LczgvZDE2bThn?=
 =?utf-8?B?Q2JrYVR1K1hEMHBCZjg2bDVCQisvek1GL1BwejRuUmFvdjh5ZUE4b1ZPQmVy?=
 =?utf-8?B?ZEc5empCYU53aFdvRG16WXZIS0k0bndGLzk0WlNnRUxNSkM0anErR1Zmd2xy?=
 =?utf-8?B?T0NrVTNMQWxmUEdoSUE2cHpUenRCaHRnczhUVlljQytVRmIySTlLNUxRWWg3?=
 =?utf-8?B?ejg3QlFmWm1QUWZXYjJpTU5Ld29NTnU0bTQrNDNRb2g4b3pnbngzaEtiL0Nn?=
 =?utf-8?B?MXdRRlMwWGNOK2RuaGZ1VkJYYTZ2VlBNWjFGWTNvcXRoYVRjK1R1d1RvQ1FF?=
 =?utf-8?B?L3VDaGY0NWRmQ2hxUVN5TnpPNlZ6b0Fac0lHVmhiM0hhcFBUd2tDVmcvdzBt?=
 =?utf-8?B?emFxSm5KUzBTZUY4MEZsS2d5NTU2RzZTT2htTVVvWlJLeUFKdFhLMWRJR2Vy?=
 =?utf-8?B?VTlxYWV3UmVlM3NEYzd1cFZ4QlRWQ3dDakswNWU3VEJZdEwydUtwUFM0MGJX?=
 =?utf-8?B?WThPT0Z4Vm1kYUtpNHNNdVh5elF1bGhSbGlqMFVlV0MwNTFHc3g2UHl6bER2?=
 =?utf-8?B?MG1DMHdxREtrNStIaUpDWjZLUFcvVXlXZTg4aHQzVU9hMC9VVTcvL3pkcWVi?=
 =?utf-8?B?aFc1cXdXQnh3OFVhdWxKOGNNSU5DYnJtSnlZY1NDaTJwTUtKZWZaU2dPM045?=
 =?utf-8?B?bXNpaGxCa1BBa0ZBdFlrdjBmTllBTDZENmNZTkdSWm0yVjA2YzU5YlpzU3dM?=
 =?utf-8?B?M1VTUktkMzl0a1BLd0RpTzk2Y0NnYkFPam5VNHU5U1NVSkpxWmg3NzM4alkx?=
 =?utf-8?B?TTZYTk8wTCtYNUxOYzdMZWYvcnVGZTNrUUZ5VGExbThoTnRRWWJtR3dTd3Zn?=
 =?utf-8?B?ZUhhOVFHQU9XL25nRk5IQWx4WkxiSGFlMzhwVkVVdGtCTlU5UFJUOWl1bUV6?=
 =?utf-8?B?eCs3d1hPTkU2SVlmamZOdEt6VGtDV3ZKanp5Nml3aVdNSzZIT2N6TnFpeHhM?=
 =?utf-8?B?YnlHWjNqQVEzeEdoeithMTRrK1U1UHpBSEUyell5RCtJaVZubEc5czRqOUFs?=
 =?utf-8?B?aEprd0RaSmgxY2tuMmxXaVY2bk8xTEdOT3NNdFo4RXZVWUdjQ05pZkl1N01v?=
 =?utf-8?B?aWcwelhZL0hwaC94ZUpiMUVtRElOQkxMTUxBekJmWlpUT0k1R3U1QTlzVC9L?=
 =?utf-8?B?bWQ3SW12MmJNTWRaOGpLR21BRnh6WW9DaGV4T1prTWp6aVBXQ2Y3NjhmTjJ3?=
 =?utf-8?B?cGVEMUdsaVRaZUhDNW13aEY5OWxtQ245RXFHbkljVWl1WnNtdWlqMUdYTSs4?=
 =?utf-8?B?WmRGM3hlYW1TSmlMeEViV3NvYWdXVWlNeDQyQzRockI1Qzh1K2F2QTgxVmVO?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <428946F44D67384D84A864753B75E4FF@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO4P265MB6026.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f75a39-1fdb-4beb-a65a-08dccb252ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 07:59:27.2048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vtERUdEV5rbN6W9ynfjn4/EtBSJskl9VQ34aK1bnKCSyg3abbChVRaOPSctaMOSVk5t91ObWRtHVcZSmwa55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7862
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=aKOiqq9m c=1 sm=1 tr=0 ts=66d57061 cx=c_pps a=6IdplsTJodF3+aqeaEJcqA==:117 a=6IdplsTJodF3+aqeaEJcqA==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=WnR_qW7rlZcA:10
 a=NgoYpvdbvlAA:10 a=r_1tXGB3AAAA:8 a=i0EeH86SAAAA:8 a=LzLeEnO3uBdfDV27W74A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: tZ05IJ5OHHyzwdWxKiRoiL36JGX6nT9b
X-Proofpoint-ORIG-GUID: tZ05IJ5OHHyzwdWxKiRoiL36JGX6nT9b

T24gU2F0LCAyMDI0LTA4LTMxIGF0IDE4OjI5ICswODAwLCBKaW5qaWUgUnVhbiB3cm90ZToNCj4g
U3dpdGNoaW5nIHRvIG1lbWR1cF91c2VyKCksIHdoaWNoIGNvbWJpbmVzIGttYWxsb2MoKSBhbmQg
Y29weV9mcm9tX3VzZXIoKSwNCj4gYW5kIGl0IGNhbiBzaW1wbGZ5IGNvZGUuDQo+IA0KDQpSZXZp
ZXdlZC1ieTogRnJhbmsgQmlubnMgPGZyYW5rLmJpbm5zQGltZ3RlYy5jb20+DQoNCj4gU2lnbmVk
LW9mZi1ieTogSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2pvYi5jIHwgMTMgKysrLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9qb2IuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfam9iLmMNCj4gaW5kZXggNzhjMmYzYzZkY2Uw
Li42MTg1MDNhMjEyYTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlv
bi9wdnJfam9iLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9qb2Iu
Yw0KPiBAQCAtOTAsMjAgKzkwLDEzIEBAIHN0YXRpYyBpbnQgcHZyX2Z3X2NtZF9pbml0KHN0cnVj
dCBwdnJfZGV2aWNlICpwdnJfZGV2LCBzdHJ1Y3QgcHZyX2pvYiAqam9iLA0KPiAgCXZvaWQgKnN0
cmVhbTsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IC0Jc3RyZWFtID0ga3phbGxvYyhzdHJlYW1fbGVu
LCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIXN0cmVhbSkNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+
IC0NCj4gLQlpZiAoY29weV9mcm9tX3VzZXIoc3RyZWFtLCB1NjRfdG9fdXNlcl9wdHIoc3RyZWFt
X3VzZXJwdHIpLCBzdHJlYW1fbGVuKSkgew0KPiAtCQllcnIgPSAtRUZBVUxUOw0KPiAtCQlnb3Rv
IGVycl9mcmVlX3N0cmVhbTsNCj4gLQl9DQo+ICsJc3RyZWFtID0gbWVtZHVwX3VzZXIodTY0X3Rv
X3VzZXJfcHRyKHN0cmVhbV91c2VycHRyKSwgc3RyZWFtX2xlbik7DQo+ICsJaWYgKElTX0VSUihz
dHJlYW0pKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihzdHJlYW0pOw0KPiAgDQo+ICAJZXJyID0gcHZy
X2pvYl9wcm9jZXNzX3N0cmVhbShwdnJfZGV2LCBzdHJlYW1fZGVmLCBzdHJlYW0sIHN0cmVhbV9s
ZW4sIGpvYik7DQo+ICANCj4gLWVycl9mcmVlX3N0cmVhbToNCj4gIAlrZnJlZShzdHJlYW0pOw0K
PiAtDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0K


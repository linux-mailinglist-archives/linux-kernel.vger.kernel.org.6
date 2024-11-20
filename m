Return-Path: <linux-kernel+bounces-415292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CF9D33FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B5AB23207
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD016A930;
	Wed, 20 Nov 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IxtD+OGb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eaq/OipL"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB8161310
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086381; cv=fail; b=qmsOf2QzjEFD8BR8RTN/zdGGUlPDz8ovbUYwOxtto1VBEp+o2k8GhoHLn5qZkjGFTArpJbjMBWKEDzoCMWbax/uNJNp0kaI6oOTdZsfEwbNo6fsX1Gl2iLrOI2k5PcRnIcYU7/QCLqV+XnCIct0u99spcYUYuTjl9O+aFHXL/Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086381; c=relaxed/simple;
	bh=xJpbs1M4di8yhy/+6n5/Ue9nMLpZ1Fapi6LLVyKyUqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxhuzXSTaIRgOZ7cUJSvXWRxFUt6yEX/qsYwHqrpByV+XeLUs3RCjOhN490vwNWHOjhnmOEGt6aYZdCDYZiLIZNpXS1CJuu34b/ZxLrqFcJyzRFkBUMNlmPEOVe9TUWZk2fTJ3lDVAgrMyEdU0vD3DPX2qgx7956SEl/v4MIe9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IxtD+OGb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eaq/OipL; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732086378; x=1763622378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xJpbs1M4di8yhy/+6n5/Ue9nMLpZ1Fapi6LLVyKyUqM=;
  b=IxtD+OGbV24mwOJICBadrVVew/SOAUjMt4OQjqOErqgwnKEkTrZZV3IG
   ij3bkexbxQ4LhyYfqjME0E6Iv7X/P3AY4DtW10+YYxWNRSD4DdpCxMjoF
   v5eTzR1navBuGMr03pt+qBxOm/sG65XsTTADlSjbhHdkRxatLzwCV1RLS
   2biEexV+xn3n2hS34ugxun8E9hdPiz87CQfmAin5kSNKmykBrmTxWRqRl
   zPcNHxkrsR8ncXRA2te8iDibZAwCu9OPPtyOQYo4ka89jHhzPbutIYkiJ
   G9BEoHRb++s3ivC70EhLtDKx1KwsC891ft6o5XuiwYAFv82NwBTdM2MlJ
   w==;
X-CSE-ConnectionGUID: WdAe6O7CS3K69qdk9+of0w==
X-CSE-MsgGUID: I2p0OZTzTYmt6oeexfNyGg==
X-IronPort-AV: E=Sophos;i="6.12,168,1728921600"; 
   d="scan'208";a="32429196"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 15:06:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fviSdyumiEWa6+IhBaAb9+zKgBFZo1T6ilUAW2KpTlQumyXI5PObEAMC4qx8jgJP514o3NVbv6aBJ+9xS6JBolAD+lEd/CZPkK299OoBk2ipnPU71NCmIFxoOi9KCG6wyb+FPncbDaOnfpf/56/Qkten1pVGW2N0asans14A+uYtRdEmveK4vins4DEXlTE8GazpkuTE2omk9yqA/hX+fxqowiUgbsfonOsPOAcMxJyriQirq0bgd8+VhVqNJ2IzxEm/kP7uv/3+M5Cm02R6obhc7ybt1/BiZD8FxJt8vgZ0TWqB4HXFNqB4BwfpJgP39jvZC1kBUX5IPSwErhaKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJpbs1M4di8yhy/+6n5/Ue9nMLpZ1Fapi6LLVyKyUqM=;
 b=DCd2YkJ+ve1VIXQAX43wngf53a5fHRnpXlB0E2JIUZQHesqOd+08a7OafW6gpJpR9/UVQWUInH4GDsj81KNUQ4S7hjGXchVhm4cXzgCU1c+iPicOCTtmNxpJQYzKK81IHsMpvWsq3il/9bnsaYCjK6dq32JZJGwhdznqt7OHFeoB+xsEnN9evEfyJrXJzC3fjYXBzdMsU+WNaGMX1QGa/+F5ah+/6KpWENaEacDK8t52oNnDYy3dDoTATyMeQtihrW90ppqsqiQTdCtQIEpl4ojVL+HgK7m0RASB4ggqzBQk0GGTqGr6krQeS6uvibqwzLxLEooVdern3Qat4XFzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJpbs1M4di8yhy/+6n5/Ue9nMLpZ1Fapi6LLVyKyUqM=;
 b=eaq/OipL8njWGJIMNk9FjdiCczveEUzVU2yhoHER9gW2zgL8ERFKyOt5/j6eRO48uZkjvOyGWPRBbdtSaAcDrKS03rhAFwYIhbxaN7aLooHUCfm//S9za1a2EKU8h9+DBARoNY4An6zbxJyib32mo+z6+PYfMSmRKG75Zb3ihJQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8555.namprd04.prod.outlook.com (2603:10b6:510:2bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 07:06:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 07:06:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: "Daniel Walker (danielwa)" <danielwa@cisco.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index:
 AQHbNeKxizzLej0qw02u6pHMIY1jfLK1ZTYAgAACnYCAAAitAIAACmiAgAAOz4CAAq+GAIAAOFOAgAR9VwCAABNdAIAADFAAgAACZoCAAASkAIAADOkAgAAWSQCAAAGAAIAAFMqAgACYawCAAQ5OAIAA08QA
Date: Wed, 20 Nov 2024 07:06:13 +0000
Message-ID: <b3bros6ztsazgzhzz3fnqg7pcv7vjyhk5fs7ne4ks6pxtneb7h@rpov3fhkbkt3>
References: <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
 <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
 <fbe53f25-2cce-4c1d-bace-e7976c4ba20c@redhat.com>
In-Reply-To: <fbe53f25-2cce-4c1d-bace-e7976c4ba20c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8555:EE_
x-ms-office365-filtering-correlation-id: 78dcb541-a4d9-4a69-9103-08dd0931d1d9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnAwTXliU0FwMjIrSlp6YmRORjQzSU8rWTJySW1GR2FVeE5Qam42TTFlKy9o?=
 =?utf-8?B?TWowU3pXQWFzSCs2MXJreldFbVJXYjlTVGxqbVcwcWRxV1ZuOFJlWnZMdDh1?=
 =?utf-8?B?Lzl2NWRmYjdLdnRHN0JpNWlrZGREMFErQm50T0RWYnpYRU51QjN4aEM3dVBS?=
 =?utf-8?B?L3VDUENpc00zdGFyd3N3WG5rZkpXcjdTOHhtSENEMndzVEhnZGRjZWxKOExN?=
 =?utf-8?B?ajNYaVVpQ3g5SmVqVFBaRkw4NXB1RU5qZS9Ca2tCMXRTN1pTbDFiRFUvRkxu?=
 =?utf-8?B?U1pDM254Y0xmdFVrNTZPNUJ3M0FtMGxETW8zWWxrMVhGMUJJRW5HZzdyV2E2?=
 =?utf-8?B?N01NRWxkMkxESXhLOVVEL3VmODN1Z1UvdWRlVFdFOWEyd0tNZ2c4dlp6NDdE?=
 =?utf-8?B?cEUxcWxxZlR0dEJINTY1eWdqbVJhYmIrcnBMcFBSTkFva3lIMnhySjFEWEpT?=
 =?utf-8?B?ZU5jTTJUbUFrREtZVExXb3d1Rlh5RlJLeXlCZnJUVXpFZW1xZmZ6Q2dlRzNR?=
 =?utf-8?B?cld0K2NzbGpMNys0VCsrbmlHWk5UdHJQaWJTUUdQSkhxUzd3NnRYYk1ud1l6?=
 =?utf-8?B?UHJxSW95YWppOFgzckMweXBtc3djV0N6WWFuRkplQUdpYlVzdktGNkxWbEs5?=
 =?utf-8?B?N3BFZElveWMvQUV6ZE5LVVpSUGFxUE45TkV5K0NKS0V5SXdiUFNFekJTai9z?=
 =?utf-8?B?dWpNdlNJS3hGeWhTa3hHcEs5a1FtVStTakNGNzBVUkxMY3lsVm5EV3dobkdP?=
 =?utf-8?B?RHlqd1lhUm1WWldOT3FqUzI5ZElCSUxYQklCVjZMTGJSL2NHUlJFMGVrSTNq?=
 =?utf-8?B?cHYydU1sZHdZTXRtaFNkOERvQy9nVVpnUE5NcmMvYkt6NVJrTFZQbWRFN1po?=
 =?utf-8?B?R1FXWW9nSnlReHRZRURIcm9kUmV1S29XMHNzSHZVV2QyZktVK0lacmJpUHUr?=
 =?utf-8?B?dUc2cWswZUV3WEdyOVUxeGhOTWJQelJ5TWQ2KzVlNGo0L05JRFVYRHllTHAw?=
 =?utf-8?B?VUNWWnVxQmhzWG9hbEwxZU0xdkdHQlNUNldQcFFFaUo4UEN5amtESWczWUdo?=
 =?utf-8?B?NHRVYVZIOFlvL1NzTVB2MU9vZ2tKU2hZaTZBN0hJRitLajdoakVSZ1lUZDVQ?=
 =?utf-8?B?VGM1VkZXV2htRmJRSG0xNlpmeis4WWZCeHpSeXNqbnNrb3dhcVBHT3c2b2xR?=
 =?utf-8?B?TVVYeG1rZkdkVjRnbkszRjhEY2FRR1VtRURINS94YlRvRFFEZEpEN2hmU29j?=
 =?utf-8?B?ZzFkV3hqM1JXSGlaTFVLaVhIcU5QOHM4UVZkZHdTR2RyQUh1djNSNHZ5TkZ4?=
 =?utf-8?B?SEVvK1djL0lwV1lOR2VzMDQxT0JiV05remVWSnh1YUVYZzA3Wm9WWE1nQnlj?=
 =?utf-8?B?ZkF2WEp4VXY5Wk9INEpQWmgzemtSREJzRXpraTZmYVlRUUJlSnhBY2IreTlq?=
 =?utf-8?B?c0h2dkQ0dS9mUXh1RGp0RlZ6RldQOWVGQjJLbFA5RlRpQUVlNzdjZ284K2tp?=
 =?utf-8?B?RzRBR1ZlVjNkQ2xTWWtnZFgxQWloZXI2Q3ZGcXVOa0hVdTMvQWI0NnFuaGxN?=
 =?utf-8?B?YzVROHdGa2ZCM1lST1RDWXpocElacGNLTk9XV09ZM2svWkZ0MUxEOEZFQ0hU?=
 =?utf-8?B?dzY0eDJ3bTNRYjRsMlNZeUJEcEJ2ZSt4VzNXdmk1VzBmbGNuWUtQNmFFaDFV?=
 =?utf-8?B?N1Z0YnA5dnBwOFZUd2xyekNTRFhrMkJJdDg4V3BsSllPdnBSOVNPVmxnTGpP?=
 =?utf-8?B?ZnE2K0trS1ZScGpuamU0VGQrY2JneGMxWEhEUTBTdnhLZ0NFMldqUkhvK25w?=
 =?utf-8?B?WjZxZnR0dTlRbFZiVHhOeWhGbVJXU2lkWE45VVVWajhEbkYwSkpISDB2NHRl?=
 =?utf-8?Q?MljGObcX+vn2K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDVFSE1lODkraExPM3FRMGcxaE5XeWpRT010RFRGaDdzMGtFNGdGYXVKZTJI?=
 =?utf-8?B?d0ZMUVJaK1JNanpid1N0cTh4N1U0bXdsK0o4SUNRUC9ibXBDdjFPS21XZE9t?=
 =?utf-8?B?Z2t0ZXpMRFlzbW9lNXUwd29aT1BYeklHaG03dFBsR1VIS3JERytQNmYxRjZz?=
 =?utf-8?B?L0hUZDRCeXFuaG1mclJONElYRDc0cWw2NVJJc1VqOVVhREpTakVKOXJZenpL?=
 =?utf-8?B?S2loc0FlVUkrZWxRK0VtQ3NXQVM2dTJObVovUTRpanY3NTNvKytQay9XVFpz?=
 =?utf-8?B?RzNnRUdvR21vV2ROVnpIdllsWXlINkFrcXlQdFJlMTdhSno4TUx6TTRWZzk2?=
 =?utf-8?B?Wm9rVFZnNmV2eEJoTnlBVTF4anJmTlpEbWFtVXdlaEJtS0EzVHp0Y2hlMXhD?=
 =?utf-8?B?MzNKQm1WbnBEeE5SRlJhK0xmOGJNWFk5UkMzWFdWU1NNcDJ2YUxoZWwxM24w?=
 =?utf-8?B?cGFYd0hGampoZnIyOFI4NEw0M0lBWmJwQ0p0RUYzVERjd2FEQ003YXlSdG5T?=
 =?utf-8?B?QzFVeEVJSWYvejZFOUxJTmdTcjVEekJoditlcVNPNXNHbUNLNy9BeFA1SEJk?=
 =?utf-8?B?c2JuTkZxRFdVc1NLOG93V0F6cVZOVVo5L2pjMWpydUx0akpqaTRra2Zld28z?=
 =?utf-8?B?RE9Pd29wc09iWjJacmlkRzF4T05XVHZ4QWRGWk1pUUJBSldMNThORit5dFBG?=
 =?utf-8?B?MlBvcERaWnVUYmxmM1VoRDR4UUZkY2VLeGRzTjl2bkNjL21zQnBTNHJSS2F0?=
 =?utf-8?B?ZTliOUYvbWF4aWhvcjk3VkRDV1F2Yld2bEt6bUFvVDNjTmUvMnpWZ1ZLOHFB?=
 =?utf-8?B?dnZXeXJXS0VVZUlYMFRqU05ROFR6QU9OZDY1Ym81MHNXejdCbUpHVmsrMTFZ?=
 =?utf-8?B?NjNtNGU0V0FUd1JpRVdRM0pzaWJDTE03ZjBKekdudHQxcXpYeVYwMldxVy92?=
 =?utf-8?B?M3lEZTd5cFk4U09VSCtFZWxRTDIrMGxLR2Q2b0NVU3ZqbE1WdGtqeWJyS0RM?=
 =?utf-8?B?aWxKYzJERlFCODNwZ21ldEdlWGZKNXI0QkpYZysxSGorenhPWXF4WXlzQU9m?=
 =?utf-8?B?STlnK3ZuM0g2OU44SytMcExMVUcvMWIzNTY1T1FEWFlnOXhFWENjVlVTeUFD?=
 =?utf-8?B?SDZJQlVkeWducGEwQjl2OXNFVkUxY3NqVFdWNzB2RERTdjJlZS9LeFh0UXpN?=
 =?utf-8?B?SU5EV3VuaGY1ZE5hNTk4VGZub2Z3Sk1wZDY2ZVVXTzE1WktLTkdkZFVnVDVr?=
 =?utf-8?B?MDV3enRoT1hFUmlBVlhvYWpKa3FSOTdWTjQxbWhUKzN2NmxMR3FXWnlwQXRr?=
 =?utf-8?B?QTZtOWVQOE9aMy9xWldZWWREWXFnY3RpQWgrK05tWTVOV3ZVVVBMNGNiS0M4?=
 =?utf-8?B?U2VNUCtydWk2L09hdkQwTkpaSVIrZUNVSnNHTU9YZWNjc0pUeWdRTFlqc09a?=
 =?utf-8?B?SDB1Vlp5QWt1aTdMaWxUNDNPT0o4bTY4bWRlTXM4TjRlQjZhWjJxTnZMNzBC?=
 =?utf-8?B?UEN6aStzR0FqemhYa0Nzc0VPM2ZaK0VJUFdXaEZtTXpiOXN2TVloYnlYZWZS?=
 =?utf-8?B?VzRxc0xKS0x2R0lWa056WEpXdUkxRG5uMnFsU3ZEcjcrdWlEL3Uvc240OE5y?=
 =?utf-8?B?OGlQOGU3d1V6YmxXOFY3M09TdDFQM1Uzc2hlbytDQ3haWU5jY2RvdzJnby95?=
 =?utf-8?B?b0NQYlBGbnZyNlNJcXZHVXNQRng4Y3VtVHpzZGZHR1djWHVXY2VnNzc3VGZD?=
 =?utf-8?B?TnBOS0pXaWRYVDR3TWZFQXhMSjFyUmtFZUptbmJ5R0tmRVVtTUxMSSs2cHJm?=
 =?utf-8?B?b002WjNKd3MyUStGN3ExRlZFWHgwcTEwTkQzQzgxaHFHbmRwemJ3ei8vMzMw?=
 =?utf-8?B?V2p6Z0JHUmZvTkZmTUhjQ0UvQ3V1UlJyUFBZbk5OeVFPZlo2elgwY29wc2ps?=
 =?utf-8?B?UnVua0pOTzJTSW1QWFFvR0lZamRUY1lzUXdhTnpValBlSlh0aHFROWxMaFFn?=
 =?utf-8?B?ZzM5NWVLWURVMEpKUCtFN2M5cE5jYlNpRFpZSnpTVVVTd3ZNdzVVVmU0SlVv?=
 =?utf-8?B?MmN6MlhZSS94YndjSUFiOVhpMk9WY2NqZ1ZvTEdIQkVIR2sycC9LS0wwU1pw?=
 =?utf-8?B?VGV4YkxtQmlHRFZwVXlvMjBWTGo0NHpyT0M3MVQ4TmRYeW04elRwc2d4RlpD?=
 =?utf-8?Q?IrgxY5d7TwFUl48r2UAJzUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E110DB8E483B274B86ED5D99A86FC72A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AX+mkaeW/Nf00iEBJAOv+IPlFPbVeyLJZVt+YvJa7wbjOfE3xwgjIj2vsV1r9M/NIPxw0i9tjavH6fL8qqmtUTN6J+tQoyqK1pJL/dYF1f5ohpPiREkBmb1kJiZ1JA06lvxQb90YiiA/fIqy2xKq1Vk41KswPJVQE3bDBAyzQzCraqeboStllEj/UDNJVIOsfO8DGZKy3fApgW+mtbzX8HopsalZWL26z/rhIwiERp0QMSD1eExYTi62wIkwwZdotkKmOBdBUzAdPmeXLI7WVmKhj16AWYBc2aEqz+xGtnm5jfjrp2oal6jk8szbD73SpT4YnkXX1nPCy3cdWwKgFuWeEqu9s62NpTrOVATKM/zhUtJj4ULdI16kcrhkhFtLSMyNHuoCxglf2kAurTCdeMnUq+hshSdzZtUP4iiR6aMDXuKzdugN5ex/p1i7yfqqapv3jDIK7187uZKBs4Yz3wC4KyKJRjC08xZfagkxeMI1VhkVt6x/IvTqvDkSf1D+mh9KyJnqe8JIH/lHuXknroFZguPXFLQFvV740DlivTXPVD/zwAW3isQ5Cwh7ogVxvWm+yROPgkgjKWaId0dOpG9eGYvraIHCiGWzXNOqobXnsS86VPtZ92weh8oeElAQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dcb541-a4d9-4a69-9103-08dd0931d1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 07:06:13.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olAd/bjhEo5y4COqaXX+NQLJG1E2qvAeKYVepqMBo54TGujKjD1P6WDMI6tY6Wim10czSM/+2T7/hTeiKPlLwHpzG2ySdRFZN/felAAC1S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8555

T24gTm92IDE5LCAyMDI0IC8gMTk6MjgsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gT24gMTktTm92LTI0IDM6MjAgQU0sIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+ID4g
T24gTm92IDE4LCAyMDI0IC8gMTc6MTUsIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToN
Cj4gPj4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDU6MDA6NTJQTSArMDEwMCwgSGFucyBkZSBH
b2VkZSB3cm90ZToNCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+IE9uIDE4LU5vdi0yNCA0OjU1IFBN
LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPj4+PiBIYW5zLCB0aGVyZSB3
aWxsIGJlIG5vIG5lZWQgdG8gZml4IGFueXRoaW5nIGlmIHRoZXkgaW1wbGVtZW50IGNvcnJlY3Qg
YWNjZXNzDQo+ID4+Pj4gdG8gdGhlIEdQSU8sIGkuZS4gdmlhIGRyaXZlciBhbmQgYm9hcmQgY29k
ZSB3aXRoIEdQSU8gbG9va3VwIHRhYmxlcy4NCj4gPj4+DQo+ID4+PiBBZ3JlZWQsIHN0aWxsIEkn
bSBub3Qgc3VyZSBob3cgSSBmZWVsIGFib3V0IHVzIGhpZGluZyB0aGUgcHJldmlvdXNseSB1bmhp
ZGRlbiBQMlNCLg0KPiA+Pj4NCj4gPj4+IE9UT0ggSSBndWVzcyBpdCBtYXkgaGF2ZSBvbmx5IGJl
ZW4gdW5oaWRkZW4gaW4gdGhlIEJJT1MgdG8gbWFrZSB0aGUgaGFjayB0aGV5DQo+ID4+PiBhcmUg
dXNpbmcgcG9zc2libGUgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiA+Pg0KPiA+PiBGcm9tIGEgZmxl
eGliaWxpdHkgUE9WIEkgd291bGQgc3VnZ2VzdCBpZiB5b3UgY2FuIG5vdCBoaWRlIGl0IGlmIGl0
J3Mgbm90IGFscmVhZHkNCj4gPj4gaGlkZGVuIGJ5IHRoZSBCSU9TIHRoYXQgd291bGQgYmUgYmV0
dGVyIHNpbmNlIHNvbWUgY29tcGFueSBtYXkgaGF2ZSBhIGdvb2QNCj4gPj4gcmVhc29uIHRvIG1h
a2UgYSBjdXN0b20gZHJpdmVyIG9yIHRvIGV4cG9ydCB0aGUgcGNpIGRldmljZSB0byB1c2Vyc3Bh
Y2UgdGhydQ0KPiA+PiBVSU8uIFRoZSBjdXJyZW50IHNpdHVhdGlvbiBpcyB5b3UgY2FuJ3QgbWFr
ZSBhIGN1c3RvbSBkcml2ZXIgaWYgcDJzYiBpcyBlbmFibGUNCj4gPj4gd2l0aCB0aGlzIGFkZGl0
aW9uYWwgcGF0Y2ggZXZlbiBpZiB5b3UgdW5oaWRlIHRoZSBkZXZpY2UgaW5zaWRlIHRoZSBCSU9T
Lg0KPiA+Pg0KPiA+PiBJbiBvdXIgY2FzZSBpdCBzZWVtcyBsaWtlIHdlIGNvdWxkIHVzZSB0aGUg
YWxyZWFkeSBleGlzdGluZyBzb2x1dGlvbiB3aXRoDQo+ID4+IHBpbmN0cmwsIGJ1dCBvdGhlcnMg
bWF5IG5vdCBiZSBhYmxlIHRvIGRvIHRoYXQgb3IgbWF5IG5vdCB3YW50IHRvIGZvciBkaWZmZXJl
bnQNCj4gPj4gcmVhc29ucy4NCj4gPiANCj4gPiBJIGRvbid0IGhhdmUgc3Ryb25nIG9waW5pb24g
YWJvdXQgdGhlIGNob2ljZSwgYnV0IEkgd29uZGVyIGhvdyB0aGUgcDJzYiBjb2RlDQo+ID4gd2ls
bCBiZSBpZiB3ZSBrZWVwIHRoZSB1bmhpZGRlbiBQMlNCLiBJIGNyZWF0ZWQgYSB0cmlhbCBwYXRj
aCBiZWxvdy4gSWYgdGhlDQo+ID4gZGV2aWNlIGlzIG5vdCBoaWRkZW4sIGl0IGRvZXMgbm90IGNh
bGwgcGNpX3NjYW5fc2luZ2xlX2RldmljZSgpIGFuZA0KPiA+IHBjaV9zdG9wX2FuZF9yZW1vdmVf
YnVzX2RldmljZSgpLiBJbnN0ZWFkLCBpdCBjYWxscyBwY2lfZ2V0X3Nsb3QoKSBhbmQNCj4gPiBw
Y2lfZGV2X3B1dCgpLiBJIGRvbid0IGhhdmUgdGhlIGVudmlyb25tZW50IHdoaWNoIHVuaGlkZXMg
UDJTQi4gRGFuaWVsLCBpZiB5b3UNCj4gPiBoYXZlIHRpbWUgdG8gYWZmb3JkLCBwbGVhc2UgdHJ5
IGl0IG91dC4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgbG9va2luZyBpbnRvIHRoaXMuDQo+IA0KPiBE
YW5pZWwgY2FuIHlvdSBnaXZlIHRoaXMgYSB0cnk/IEl0IHNob3VsZCBmaXggdGhlIHJlZ3Jlc3Np
b24geW91IGFyZSBzZWVpbmcNCj4gd2l0aG91dCBuZWVkaW5nIHRvIHJld29yayB5b3VyIGNvZGUg
KHJld29ya2luZyB5b3VyIGNvZGUgdG8gYmUgY2xlYW5lcg0KPiBtaWdodCBzdGlsbCBiZSBhIGdv
b2QgaWRlYSB0aG91Z2gpLg0KPiANCj4gU2hpbmljaGlybywgY2FuIHlvdSB0dXJuIHRoaXMgaW50
byBhIHByb3BlciBwYXRjaCB3aXRob3V0IGFsbCB0aGUgZGVidWcNCj4gcHJpbnRzIGFuZCBtYXli
ZSBmb2xsb3cgQW5keSdzIHN1Z2dlc3Rpb24gdG8ganVzdCBtYWtlIHRoaXMgYSBzZXBhcmF0ZQ0K
PiBmdW5jdGlvbi4NCg0KU3VyZSwgSSBoYXZlIHBvc3RlZCBpdCBbKl0uIFJldmlldyBjb21tZW50
cyB3aWxsIGJlIHdlbGNvbWVkLg0KDQpEYW5pZWwsIHRoYW5rIHlvdSBmb3IgdGVzdGluZyB0aGUg
dHJpYWwgcGF0Y2guIFlvdXIgY29uZmlybWF0aW9uIG9uIHRoZSBmb3JtYWwNCnBhdGNoIHdpbGwg
YmUgYXBwcmVjaWF0ZWQgYWxzby4NCg0KWypdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BsYXRm
b3JtLWRyaXZlci14ODYvMjAyNDExMjAwNjQwNTUuMjQ1OTY5LTEtc2hpbmljaGlyby5rYXdhc2Fr
aUB3ZGMuY29tLw==


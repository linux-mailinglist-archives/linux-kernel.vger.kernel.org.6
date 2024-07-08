Return-Path: <linux-kernel+bounces-244032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAD929E31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590521C21E42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A43FB1B;
	Mon,  8 Jul 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A69AkR7a";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d5JiSbQU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA617583;
	Mon,  8 Jul 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426888; cv=fail; b=OxEsdn4cmIj3Sf/xUPIYStauKLW8JND8QX8UzKgcwFrurKVG8OnNChepMcYrcs852CUPix1DK49sMxJPk+I15dYTRYMHvB7wfH4Q9tW5yb/Rrt6cFg94by7ZPReFfgEzpwgWgX5DbbTe5a7ZqNaHrB/wH/CaADdCFZmT3gPWf1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426888; c=relaxed/simple;
	bh=RgXKvpfM1thRom/fXNscAtUjjv3x13G5VfOLXjkWcv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aItsomm3liJfXp0XY+5D+XeUY8vU7YE0qEFAWG0KQN+FQShUdQZqTC/eyQUB6RLF8R3MM/WpbfV3hGBcPHgsJ71/pmpkTvv7JRYMtS9bUD1pXdc57FtfYIbTB37h81ck8efGo85P9LFcAaeSJq3ApMz8CtE2N0BqTL7+KaWxGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A69AkR7a; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d5JiSbQU; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720426887; x=1751962887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RgXKvpfM1thRom/fXNscAtUjjv3x13G5VfOLXjkWcv8=;
  b=A69AkR7aRJXnSwrImnlkcYoDt8RSB/hGLtoAcZDbUy52bZTQx5ZKfkpg
   LgkDVqfyWcoEtg5joc722ed9hEKXeRyp5loWelOOE9oR2i44qgLHKnhd5
   GRyLgfbLozJpEd1y4nTFnlIo3K47DcjKeRSlGNpBQlVnONN1bge6U/m51
   IdJtD89yZx5MtwwtUM/OX8JcTaEdTFmdbazrraCU1GoHn8Eg3SrgEg0f/
   jcWvQSHFWWKqxf/SlEcfObnlu6J7gwEU6e0aD2POtgV7kESDKU5I9K9mE
   DAUIIIaxWe8QYBpd7EfB3wugMPy1+dLsg/SEp/TASWQPTa+gzV93dOVwX
   Q==;
X-CSE-ConnectionGUID: kDkgyDpPT/uCxlec6z6jXQ==
X-CSE-MsgGUID: r12dQKJiTzycK32ZI0iCXw==
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28948660"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2024 01:20:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jul 2024 01:20:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jul 2024 01:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjns5UkoLPmZvs7IudSWhiCjblklgDo20xYxk/MJhqpZgMYNzhS9NEhOVvAbjapQKR0SzoGGmQAoe+macFg4iArxKR5E05g4orhTv9tRRppDuuo84j6SV0eAfIuyTWA9sMBukfbwmcPN1Wvv9zdStbldxPzKphPRsIwS7oQiadIwdgWQVPHKQ4CoihVU9uUYZuQAIQtW6sIyHs0ub0xrnW9RzlOIfZdWwA5k16gNMoMrm5Wu2X+EvhMych+oqNSUSbElSYvznyq6LruW8lC6zOpqL8n6uRWNxjLiBFzfpQH3hzzyRAdB+rywk2XlA0OEcXdPuid3/g5wW58dppsryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgXKvpfM1thRom/fXNscAtUjjv3x13G5VfOLXjkWcv8=;
 b=Vs7A/kbzYITMLNxBOVDt4bquONBe3JlfzmdW0jLnyGcQLQw8WCpg0k10GnRbNdMMTY45VWFUaD0o3FxtJky/rQEAqm/hs3mfENT/prtWSRVTVKL5xdoyYyU4V6elkvipKtqXaqOfpYmbOsL5v5yeHOn9f2PxfwMZwybSNprLPPK6QT9gatqOLbEmbP5Ynek6pQpoVD6SxsgWmIUlAdfRIyiNVeQmQdcvP32FtY7tI5moIkmC7yHc27QysLMwNLyRnUjNwXir+yBuXvzebgvW6bL5odSe+U1UVqC7rPfudKEXlrb4SgRa+5Yi0jRVRpoA2AuXAoUVzG3AMWsAzT2nPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgXKvpfM1thRom/fXNscAtUjjv3x13G5VfOLXjkWcv8=;
 b=d5JiSbQUlyfb+IUaWKn+yquEhpyRZC2BMR0ieHKdlKkpRAv3kWdwz//Ku7oquTcX7rl+uWwa6e4L7v8vNywLt3g+y2wruWCa3XCPifYGvzjdK1qYIgPvkWGN6W3GBiEzDzlMnRMJ2y5ixhQES3A8jnPN5WMNmZukkaHg2GcYFQMObbwW0w1AalP/mPxWje2SZlDeMyw5TToEsS2MNCXBWrRR+gMNcCRtpirD5iieUEklW8psMLECO2QDgKD9493JJbMu5cbCL9K3igwUcdljpeD/DrLVA25u8a9+qI7fchubXeB52t3WBGTIrgqkFsVS2g17VkhEtIxDoJ1EMeHZfA==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:20:07 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%4]) with mapi id 15.20.7741.017; Mon, 8 Jul 2024
 08:20:07 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>, <devicetree@vger.kernel.org>,
	<claudiu.beznea@tuxon.dev>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Thread-Topic: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Thread-Index: AQHazqNsJ5qqZdCyx02jW3ZKE1QmubHsfmMg
Date: Mon, 8 Jul 2024 08:20:07 +0000
Message-ID: <PH8PR11MB6804471EC8A42CB9BBAB999682DA2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240528153109.439407-1-ada@thorsis.com>
 <20240705-defection-septum-dd9202836b23@thorsis.com>
In-Reply-To: <20240705-defection-septum-dd9202836b23@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB7961:EE_
x-ms-office365-filtering-correlation-id: 5d39f555-07cb-46f6-fb04-08dc9f26c6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2xlZjZMZFFRWSt4UGpUUUpsUkNqTVRuQVFLSWN3OW9kelQ1ZU04aC85R2NE?=
 =?utf-8?B?WVRSTWlhalQzY0NYcm05b3RVRGZNY0hqUE5CNC9OdXFLMmZxOUVJWkNpTXAw?=
 =?utf-8?B?ajNmaExORmpXY24xOUxiaDV6dUczUFY3U0gveEozQVZ1dTc2RjE2THVSNUVV?=
 =?utf-8?B?bnBZNHpKeWdmR1NGTW5ucVBqU1hYVnNvTWp5MFpUaUdWNlpQYmg1V0JIQWpE?=
 =?utf-8?B?ZmpVVWVNUTh3M1FmMWVnU2xiVDZFMzdyMnlDRTc0aGtockFhWlE5TUlHVUhm?=
 =?utf-8?B?cit1YllLQWRJaDZvTXpjWERrcnNITmU5U1JWUUNpb2dLZ0pFRk90b1BqZDdL?=
 =?utf-8?B?QlI3U0Y2cTZRdExlNW1PWFUzaVdKUFNWeis3KzZmcVpTL3JXRkZENmh4aFdK?=
 =?utf-8?B?RE5SQnpvb09hWVRCNG9NMXNEUFN1cVIvekFSRy9iWStiRG5BcDBDYTZoOVl3?=
 =?utf-8?B?V2dPUzFmcnBMOFRSUGcxZG1RNkhaSDRMVEoyaGtiTXplWFUxYkJtKy9WYUtx?=
 =?utf-8?B?ckpRc1dPOWd3U3U3UUFnNEZKUVRXbGRvSVVuRng5b3ozRFM1dWxiN3hvRFd1?=
 =?utf-8?B?VnpuK2NkTEZCVzF0dlg0TG9NbEc5c1E2TU1NalZzU01adFg1OUpybVVmK3Nv?=
 =?utf-8?B?WENSVVg0UXUwMmUrS3dLcjA4ektvb0prWkxoWFVPVlFkOVQxM1BVV1h2bWU2?=
 =?utf-8?B?M1gvZDlVVzZoeFNIaWZFcnNQN25COFRRQWMwdlNiV3AwZXNZc1h1RjE3eDRW?=
 =?utf-8?B?Y0xKNXZWeWxOdk9QVW9QU0tBVWIwVnRlT1BhOTdJOUhiYnZsVlJoNmdEeVo2?=
 =?utf-8?B?YVZNRVM4R3NoTmxjamRQWXd5TzE3VGZYVXhSZVpwZ3k4MUptaXlHL1lKWTNu?=
 =?utf-8?B?VllXR2Y1TzdwVi8wR3VFVXRJSGhiaTM1Q2ljVnVuZW02V1Zpd1NyRmVYUEM0?=
 =?utf-8?B?d2NhdDlLRFV3UGJ6YndLNlZ2R2xKV25sV1YrbzFSSkowQ1N1TEdtVUdRaGI5?=
 =?utf-8?B?Y1pLOUlpelc3dk1FWndLNWUwTVFxQlhQUzdhR0UrZko3bHY3NWxzc2laSWow?=
 =?utf-8?B?YUhHdUd6ZkRzc3F1V0paUnlQSU9NQ2J2bU4xejBXNlVzL013TEpzd1kxQmhR?=
 =?utf-8?B?MHlGWG1KZFhUMW9PU1U5V05LdG16TFd0N1Fxd0t3RU1wTW5oOTJRQ2N2cmJy?=
 =?utf-8?B?MWFEcjA3cnZ3K3dIL1NqaXJuZldOMHBoRTJqeVBPWmk0ZzN5Y1pCTnFSUmEr?=
 =?utf-8?B?cHBPdE5TZDRzYXp2Y1ptTkxsa24vN3pBZVBHZUNKN1dDT1daYUcwOTNDSmNK?=
 =?utf-8?B?cVk5QXNlV0Q5WHpZM0x6dnV2Z2pkZjBJSlhYUDdvdktkS3RrdHVjWEdvVDU4?=
 =?utf-8?B?blkwbVNkUkJxVDFJUjJ4bjRvT1NJTVVWRWhEcmpKQmMxY1JjdnlVUXR2bWFl?=
 =?utf-8?B?WHpWdUZ5eXlvelVkeU1BYnVVcG5UaFVNcWR6d2tpRE1SWnpqOXdodW9MelNQ?=
 =?utf-8?B?bVpLdDVDZEx6TTBXMUFUQ01vT202Y2EwOVpMM09uRkJpdlN4TEdPU3gxK0dx?=
 =?utf-8?B?NFdMOFdEN29kZ09SV3h0Zjk3L3dacHA0OXZ4c2h1MzA4bEw3SERBbUlyVVJ0?=
 =?utf-8?B?blVTSFdPUFhSR1dPWHkwL01RaFVKUHFaRzJOV0syVXVCNzd3TURIcVppeFU3?=
 =?utf-8?B?aC80c2RjQ0JFcE5aTjZ6Zit1SGhqV1pCYmgyMEJKWENiV3ZGNTllZW5UT203?=
 =?utf-8?B?T0REVnRXcmRMaFhubmdVc0U5bUQ4UFFkMkJXUHh0SjBwNmRnWFRLUk1WYksz?=
 =?utf-8?B?RWxuanVCbk1KOWk5aFZIZzlaRno5RlVMdHFwalFNdUVENWJuYXNLT1M5amc2?=
 =?utf-8?B?TUNYNGw5R2tpSlBhWXB6VEpKY00vMGtJOEw4VnhvYlB2TkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW5Yc1hmeW5CY29ORE0wVkpsUm0zVXdtRk5xR2h6YlkzaWdGbUM4WStib2Er?=
 =?utf-8?B?encvdGxIU1pYZlZhY2R6YUwzQ2dGUGxZaWJJM2ZRejdsQlYvMm95Y0pVZzZm?=
 =?utf-8?B?aDFncTkxTkVaZjlNY2pCUkZDdmY1WXo0dzFoWHRDWG1HVTVCUXJjVWkxQ3VW?=
 =?utf-8?B?TCtxREwxS2VRKytxNS85RVd5TDJVTFhKelhxTjRWaHNpRzBGS09QY2Q0eEpI?=
 =?utf-8?B?aVNTeUNkWllmVnhhUkFUa2xqZ003VWJyM3h6Zlhiemg4UlFudGFiaXlleGhM?=
 =?utf-8?B?MDZTckJTTGhpYjdxQ0ltaXJFanVUSHVGeklMTUMrMWFaTWo4V3ZXamVnN1Zj?=
 =?utf-8?B?RXo1V1R5T3RTN2xvekZOWE82c1ZqV1EzeDNNbjU2dEtGeUpNN3ZoQ2E0eVpE?=
 =?utf-8?B?UXdiLys5ZkZValUwazA3aTNhUkFjMXBzekRkamhLNjFneFg1S1orNzVZVGN1?=
 =?utf-8?B?VnhRdUpqRU15dkNoZEVlMDBXbXJJQXNHeXVsVzduOGc1ZkNDbXZCTFNwZFh6?=
 =?utf-8?B?OWRJQXpmbFJmYkZ4SWY5SkFiNnptYVExSUQ5SElOWGN1RFo4dGJackpObXRR?=
 =?utf-8?B?UjR6dFJDYzFuMSttazQrTEdjK2d1azJKYmlFM3d0ZWtpN0o5TExmeXVCK2tz?=
 =?utf-8?B?T01jVExjVk03NEw2NW1IVjNrVTN2bGl1NlR4Y0ozTWxHcm4xWmJIWHc2VzVI?=
 =?utf-8?B?YzFKc0JJSEowMVNyVUs0QjYwOHhBbGpVWndSOXFFWlMyVlFSN1E5Q04yRjJj?=
 =?utf-8?B?T2grMG5JUDFFNEs2WmpWcWVJOURXd0FBemlGc0d3SzFobFVYL05nczBQWU84?=
 =?utf-8?B?MmFnQ0o5ejd5Q0VGaHVsaWxaTWNza1B2M0JIUUorbnlnWXA2RW1CSGx4WjdN?=
 =?utf-8?B?ME1rTFNMVzdteFB2eU1FRWV6ZzRNY282OGpuR3piWWN3NURkYTZ0OXhONzE5?=
 =?utf-8?B?N3BKRFNyOEduOUc1R3gxR0pGQTBFSkNZa3ZCdG1SOExKaWVOU09iek51c2sv?=
 =?utf-8?B?S0pFcVFKNS9DNWtWZ3VYc0JUYzRmTlJ1dDNUOVd4M0JKaUl2cS9BUy9Caktj?=
 =?utf-8?B?SU9xYXdnTUljOVVuU3I1WXBBSnVLNWk0Y3J2S3Q1QlhQSmhuQm42c3I3TGlG?=
 =?utf-8?B?cklSbGVrWWpiUWZyOW5CZlN1QVI1T3FsVVplNkErSzFUdE1Rdjl5bFdzZm9Y?=
 =?utf-8?B?UDJuZXFyNlg4QkNaY2RuYUhIZmo0UjdSM2pSQUkwMU1LT3VTRWRWZFBBUk56?=
 =?utf-8?B?b2VRTWc4akFDT1QzVk1VbmVWWUNRSFl6Mmk2eWVWeGNBOWhZS3pQZjhmd05n?=
 =?utf-8?B?OEVXSkF5dk1KQTRmYWxtMXQ3dzVKZEdzeTVnVkRGYTFDSzBjOVVTTEZ6WFAw?=
 =?utf-8?B?QW9XZ3I1UXhnRURIODV5ckM5QTJiUzBXb0J4U2VaZS85YmdSQ2pjd2ZDNlE3?=
 =?utf-8?B?aXdGUk9Eay9XZlE5bDEyTXZSMEo2TkdGVXl6R1VKNkRFSno4bE9NbzZURFVu?=
 =?utf-8?B?VCtuUFN2OS9VRVNRUm9hcDl3dFlsYkIxL3hWZk5IY1duenFrUFE0TjVHWnpx?=
 =?utf-8?B?Vy94VHoraDR6S1grN0ZvaHphQnFmLzJ6VW1KWmlKSmJxNUVvdVhOT05aL1dn?=
 =?utf-8?B?TVpjWmZSTUtHRk96a25TdSt5a0FmSXVJNE92ZmlvZGpBNVVJVkp5ajg2L3hP?=
 =?utf-8?B?bUswRi92TER3Y2RQMDl0UXFOSnhYcHNQNmdqTytFUExpcHBELzBsUTFlYk1O?=
 =?utf-8?B?anE2OWl6ZlgvYzZzajlXRnEwd0RjdVJRTldXdTBUOWdHNUo0cWhYaGk3K2VN?=
 =?utf-8?B?NDRORWkzejlWcFJVYjJxbHprdkRlU2NseWJSMGVzWXdtdk5RQ3hia0ZETjky?=
 =?utf-8?B?VXFXT3ZVT2FpMWJMSVIvKzJKQ0pqdUQ0WFRhRUZTQXlJeVBvQ2VhbEx5VWJi?=
 =?utf-8?B?R3MvTWc2MDl4amxycTNXZmdaZGt1UkE1cENuMWN2NDVzUEFjTDN4ZUNOWjdi?=
 =?utf-8?B?VGVpTkswaW5SOG9GRWg5K2JQaytsRGlrZzYwM2Q1c2UwRTZRZUIzQjlVWmgx?=
 =?utf-8?B?U01TUElCUDZNYUFIU1BIYmFXbU9VOW5FUmFDL2ZXTlEzaW9oUExYSFFZQ1lK?=
 =?utf-8?Q?wnGbEg3HX6XihPz/zKi8HieOe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d39f555-07cb-46f6-fb04-08dc9f26c6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 08:20:07.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKqUXh3CwFDHOBGcJnQgMPpPi/cK/+4nTJSZbSMBoycnSGA2pnC9UoBgO+EW4KAzV77MAEVDgeMfkSPlI3ZCNfwMFtWvj+u8cJ0Gn1o4VRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961

SGkgQWxleCwNCg0KSSBhZGRlZCBDbGF1ZGl1IGluIHRoZSB0aHJlYWQuDQoNClJlZ2FyZHMsDQpN
aWhhaQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQpBbSBUdWUsIE1heSAyOCwgMjAyNCBhdCAwNTozMTowOVBNICsw
MjAwIHNjaHJpZWIgQWxleGFuZGVyIERhaGw6DQo+IFRoZXNlIHByb3BlcnRpZXMgYXJlIGNvbW1v
biBmb3IgYWxsIGkyYyBzdWJub2RlcywgYW5kIG1hcmtlZCBhcyANCj4gJ3JlcXVpcmVkJyBpbiBh
dG1lbC9taWNyb2NoaXAgaTJjIGJpbmRpbmdzLiAgQWxsb3dzIHRvIGFkZCBpMmMgZGV2aWNlIA0K
PiBub2RlcyAobGlrZSBhbiBydGMgZm9yIGV4YW1wbGUpIGluIG90aGVyIC5kdHMgZmlsZXMgaW5j
bHVkaW5nIA0KPiBzYW05eDYwLmR0c2kgd2l0aG91dCByZXF1aXJpbmcgdG8gcmVwZWF0IHRoZXNl
IHByb3BlcnRpZXMgZm9yIGVhY2ggaTJjIA0KPiBkZXZpY2UgYWdhaW4gYW5kIGFnYWluLg0KPg0K
PiBGb3VuZCBvbiBhIGN1c3RvbSBib2FyZCBhZnRlciBhZGRpbmcgdGhpcyBpbiAuZHRzOg0KPg0K
PiAgICAgJmZseDUgew0KPiAgICAgICAgICAgICBhdG1lbCxmbGV4Y29tLW1vZGUgPSA8QVRNRUxf
RkxFWENPTV9NT0RFX1RXST47DQo+ICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4NCj4g
ICAgICAgICAgICAgaTJjNTogaTJjQDYwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX2ZseDVfZGVmYXVsdD47DQo+ICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPg0KPiAgICAgICAgICAgICAgICAgICAgIHBjZjg1MjM6IHJ0Y0A2OCB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxwY2Y4NTIz
IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDY4PjsNCj4gICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiAgICAgICAgICAgICB9Ow0KPiAgICAgfTsNCj4NCj4g4oCmIHdo
aWNoIGNyZWF0ZWQgYSB3YXJuaW5nIGxpa2UgdGhpczoNCj4NCj4gICAgIFvigKZdOjIzNi40LTE3
OiBXYXJuaW5nIChyZWdfZm9ybWF0KTogL2FoYi9hcGIvZmxleGNvbUBmMDAwNDAwMC9pMmNANjAw
L3J0Y0A2ODpyZWc6IHByb3BlcnR5IGhhcyBpbnZhbGlkIGxlbmd0aCAoNCBieXRlcykgKCNhZGRy
ZXNzLWNlbGxzID09IDIsICNzaXplLWNlbGxzID09IDEpDQo+ICAgICBb4oCmXTogV2FybmluZyAo
cGNpX2RldmljZV9yZWcpOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0KPiAgICAg
W+KApl06IFdhcm5pbmcgKHBjaV9kZXZpY2VfYnVzX251bSk6IEZhaWxlZCBwcmVyZXF1aXNpdGUg
J3JlZ19mb3JtYXQnDQo+ICAgICBb4oCmXTogV2FybmluZyAoc2ltcGxlX2J1c19yZWcpOiBGYWls
ZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0KPiAgICAgW+KApl0vbGludXgtNi42LjI1L2Fy
Y2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9zYW05eDYwLmR0c2k6MjgzLjE5LTI5OS43OiBXYXJu
aW5nIChpMmNfYnVzX2JyaWRnZSk6IC9haGIvYXBiL2ZsZXhjb21AZjAwMDQwMDAvaTJjQDYwMDog
aW5jb3JyZWN0ICNhZGRyZXNzLWNlbGxzIGZvciBJMkMgYnVzIGFsc28gZGVmaW5lZCBhdCBb4oCm
XToyMjguMTYtMjM4LjQNCj4gICAgIFvigKZdL2xpbnV4LTYuNi4yNS9hcmNoL2FybS9ib290L2R0
cy9taWNyb2NoaXAvc2FtOXg2MC5kdHNpOjI4My4xOS0yOTkuNzogV2FybmluZyAoaTJjX2J1c19i
cmlkZ2UpOiAvYWhiL2FwYi9mbGV4Y29tQGYwMDA0MDAwL2kyY0A2MDA6IGluY29ycmVjdCAjc2l6
ZS1jZWxscyBmb3IgSTJDIGJ1cyBhbHNvIGRlZmluZWQgYXQgW+KApl06MjI4LjE2LTIzOC40DQo+
ICAgICBb4oCmXTogV2FybmluZyAoaTJjX2J1c19yZWcpOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdy
ZWdfZm9ybWF0Jw0KPiAgICAgW+KApl06IFdhcm5pbmcgKGkyY19idXNfcmVnKTogRmFpbGVkIHBy
ZXJlcXVpc2l0ZSAnaTJjX2J1c19icmlkZ2UnDQo+ICAgICBb4oCmXTogV2FybmluZyAoc3BpX2J1
c19yZWcpOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0KPiAgICAgW+KApl06MjM0
LjE5LTIzNy41OiBXYXJuaW5nIChhdm9pZF9kZWZhdWx0X2FkZHJfc2l6ZSk6IC9haGIvYXBiL2Zs
ZXhjb21AZjAwMDQwMDAvaTJjQDYwMC9ydGNANjg6IFJlbHlpbmcgb24gZGVmYXVsdCAjYWRkcmVz
cy1jZWxscyB2YWx1ZQ0KPiAgICAgW+KApl06MjM0LjE5LTIzNy41OiBXYXJuaW5nIChhdm9pZF9k
ZWZhdWx0X2FkZHJfc2l6ZSk6IC9haGIvYXBiL2ZsZXhjb21AZjAwMDQwMDAvaTJjQDYwMC9ydGNA
Njg6IFJlbHlpbmcgb24gZGVmYXVsdCAjc2l6ZS1jZWxscyB2YWx1ZQ0KPiAgICAgW+KApl06IFdh
cm5pbmcgKGF2b2lkX3VubmVjZXNzYXJ5X2FkZHJfc2l6ZSk6IEZhaWxlZCBwcmVyZXF1aXNpdGUg
J2F2b2lkX2RlZmF1bHRfYWRkcl9zaXplJw0KPiAgICAgW+KApl06IFdhcm5pbmcgKHVuaXF1ZV91
bml0X2FkZHJlc3MpOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdhdm9pZF9kZWZhdWx0X2FkZHJfc2l6
ZScNCj4NCj4gVGhpcyBwcm9iYWJseSBzaG91bGQgaGF2ZSBiZWVuIGRvbmUgd2l0aCBjb21taXQg
ODRmMjNmMzI4NGQ1ICgiQVJNOiBkdHM6DQo+IGF0OTE6IHNhbTl4NjA6IG1vdmUgZmxleGNvbSBk
ZWZpbml0aW9ucyIpIGFscmVhZHksIHdoZXJlIHRob3NlIA0KPiBhZGRyZXNzLWNlbGxzIGFuZCBz
aXplLWNlbGxzIHByb3BlcnRpZXMgd2VyZSBsZWZ0IGluIHRoZSBib2FyZCAuZHRzIA0KPiBmaWxl
cyBpbnN0ZWFkIG9mIG1vdmluZyB0aGVtIHRvIHRoZSBkdHNpLg0KDQpJdCdzIGJlZW4gYSB3aGls
ZS4gIElzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoZSBwYXRjaD8gIE9yIHdpdGggdGhlIGNvbW1p
dCBtZXNzYWdlPw0KDQphdDkxIHN1cHBvcnQgc2VlbXMgdG8gaGF2ZSBzbG93ZWQgZG93biBzb21l
aG93IGxhdGVseT8gOi0vDQoNCkdyZWV0cw0KQWxleA0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRlciBEYWhsIDxhZGFAdGhvcnNpcy5jb20+DQo+IC0tLQ0KPiAgLi4uL2R0cy9taWNyb2No
aXAvYXQ5MS1zYW05eDYwX2N1cmlvc2l0eS5kdHMgIHwgIDIgLS0gIA0KPiAuLi4vYXJtL2Jvb3Qv
ZHRzL21pY3JvY2hpcC9hdDkxLXNhbTl4NjBlay5kdHMgfCAgNCAtLS0NCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL21pY3JvY2hpcC9zYW05eDYwLmR0c2kgICAgICB8IDI2ICsrKysrKysrKysrKysrKysr
KysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gYmFzZS1jb21taXQ6IDE2MTNlNjA0ZGYwY2QzNTljZjJhN2ZiZDliZTdhMGJjZmFjZmFiZDAN
Cj4gLS0NCj4gMi4zOS4yDQo=


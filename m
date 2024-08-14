Return-Path: <linux-kernel+bounces-286593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A3951CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E414BB29920
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6971B32C5;
	Wed, 14 Aug 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="seEb/dxX";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6uhHiMOm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F81B1418;
	Wed, 14 Aug 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645206; cv=fail; b=NUYPnQWCiZhnVpP59uOGu7IE/AIkV5DnXCssuyzuirvPxGlEaTOQRuZGc2UkIV7kL5V+zRykFNz9OKznComyRSUGErEF7lVWYxixgc5aqZL8ztioiwZuHCZRZ4vqb12iY6e5S8EjnqQ2p+BpuP8YX/v7s92eLyiXtS1KQEzf4gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645206; c=relaxed/simple;
	bh=62aJRSDRWPuZ9bsrztQh/AMMz4vYGJ3FmNIYKbUxYaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXNLL94bChuL2Zix16SxyA0KVwBr4QGoiXNhV5ERafmEHnI/i1XZofs5tBFpAfxkEX1TFex5/IaqrZ0n0fLFPRkkP9YpdcJxmDBuwPk6nRf0Syvv/2047/wfHLPLtOx5D3DAmUqcbPTZn9VwGjTsmdVPBN7cQx9SLqmtS4acJYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=seEb/dxX; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6uhHiMOm; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723645204; x=1755181204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=62aJRSDRWPuZ9bsrztQh/AMMz4vYGJ3FmNIYKbUxYaw=;
  b=seEb/dxXFaQhjYyOxpbzSE1SZN3UrrBYhyAFKE6tvl5t0p/aarB0kvbr
   Z1o6XBw3KLR4Q8VgbAOoF6IYPZtI3pTTvh7bDCkeQvuI/FPmVsOKMow9+
   pm3/+qzIA48GYH4SVp0TlSV42Ok8WPUyroYuoKZWxt3w9NStOLPBxdYKm
   VHf2HJdQ73Ze+tn5LqsrzDTEXlh0n0Ajee+DS/ri6up6wsOcNqVvsrvfb
   61tQN9VCLZDM/PfiFrl22R1d+rutHSctYhV7kfTPhyQLyUjmUrLhu72u6
   X9ExjvTtmlAjZTGQ8cmPNsUOOHJpA4OYehmtjSVs7ilbtbPmGigwG/KcE
   g==;
X-CSE-ConnectionGUID: Ha4h73V5SiaK46N/+R2CgA==
X-CSE-MsgGUID: yrclM8fVQrCefOYnUVS4rg==
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="30448157"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 07:20:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 07:20:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 07:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akSFd2FFIv8cc3Em5WIpmv+qzeMHQPOF2QFYS+Pt5Ngo4e4s9zc7FwnmdyLyzun/2i+ciRGEP+DtkDCH/jlzMFNvVhDd1oO6BRt14Ni8UurTmEIIH0rDkuXhfCGjfhDOLXiB7VbxvFDz+fu7I5ev7I42ZIqmw3/qvmP4BUinmQZyb7AFH4yjenzvNFMqKiC5MCQfPFeC2B6krUg3nvMAYlI1fqby3hwh6xiOly/lZiftEInq/k+0fkcbPDHoBCl7h4t7GLwTzXkTm9scriqW0M7kYOnGjAoRtWG53j6/LfRlCD61B/oUUHX77+9ssBrxkne8ZsMgpngjx6lQgrqZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62aJRSDRWPuZ9bsrztQh/AMMz4vYGJ3FmNIYKbUxYaw=;
 b=InlaMzvuuEnZaS07SH1TE46zAW4k4SjEHF8wMUq+NqO8YdIDpZWBqD+mdDoNKQqL6IpkXsPlPD7hnZ6bIM16PxRsuisS/ZSLmVmK8v+duAn7NxusLXH6yWNi3j/+330KJi2m0OJsNfkqeMjFEC7nmmxIDBv0Sdgoik98ZN+3/4rcMK2yKwWWbH5L9Lts0s3j156YBLGgqYlp20jp9MA3OSJwDHRjFewIgYotiTnrCdAIqIgEe3ylYiJpGkYczdeXyvpNmj0gWAhU4fykTpi+NcOoTbDJJC1vcPalpnkeSxyZ8yKM7Aa6SxGnBLfCmhniD8f/0mnqVd0mliK0u5PbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62aJRSDRWPuZ9bsrztQh/AMMz4vYGJ3FmNIYKbUxYaw=;
 b=6uhHiMOmCHpxCbB+n+xRj48yqA9gMA9nbSReI3z+HvyINU2aqMr7utGCIbbliFiyLPqjslm6cvdCDf9KhpoWcyydK8d7Dvb+j2IZ+fM5sNXTVGs84L2Wk4epA8e6WDPWyhr2R4veMIMAufLs7b8E3U3tWqJsRTjjfsGctAHqT96GWL27HvtnNCLHOEK/5+LJu7eyLGHPWkT0zDX5vB6zmuFrO0jGvd7Ew/bkFxDAPXY+LPTFoqxNovgx44/BPNHuA72pYr0PgrzlEiJBfiLtEVfYxgBUfSSGfZaTc9iJ5XOgNFjGCrhVM8iiAwS0MTBc7XUfKxVc4iG3WauBOdoHPQ==
Received: from CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 14:20:00 +0000
Received: from CH0PR11MB5284.namprd11.prod.outlook.com
 ([fe80::abf1:f70c:ef88:a2a6]) by CH0PR11MB5284.namprd11.prod.outlook.com
 ([fe80::abf1:f70c:ef88:a2a6%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 14:20:00 +0000
From: <Andrei.Simion@microchip.com>
To: <krzk@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and indentation
Thread-Topic: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and
 indentation
Thread-Index: AQHa7kWFNuwNC7bEvEeRwM7Smte3h7ImvNOAgAADlICAAAbbgIAABk6A
Date: Wed, 14 Aug 2024 14:20:00 +0000
Message-ID: <19500a08-89b7-4853-9708-350320d3aa3c@microchip.com>
References: <20240814122633.198562-1-andrei.simion@microchip.com>
 <20240814122633.198562-2-andrei.simion@microchip.com>
 <3294e2d3-5142-4d7f-89d3-35528f26066e@kernel.org>
 <5e37e263-ee00-41bd-a650-1c1374e24d66@microchip.com>
 <a71f5d8e-57bd-4e8e-b0fa-8b9468ec96eb@kernel.org>
In-Reply-To: <a71f5d8e-57bd-4e8e-b0fa-8b9468ec96eb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5284:EE_|SJ0PR11MB5024:EE_
x-ms-office365-filtering-correlation-id: d5c11fcb-f19f-477f-5f33-08dcbc6c2e72
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5284.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjl2YzVWVEQxOWNZeWd4a2pFT2hUVUxXcnpYaFBhQzJVY3pFZzZtRi81akM0?=
 =?utf-8?B?RmxCK3RWZHdXeUxRd1VKYlBWQks5NXM2ZzgvOEQ4UTVVWmpUejhXbjNRbmlL?=
 =?utf-8?B?Wm9pcjZNd2Z1UElNcForMzExcG1HM2tuRzhOM1lLTkJWV2RXWDF3djMwZVI2?=
 =?utf-8?B?U3cwTFNheHgxT3dtU0dCZFdzcmhyQkx6WSt3OVFkTXZ4aDkvTFo0WmI2b0dz?=
 =?utf-8?B?dG50N0g0bEtTbFFpMXRKLzEzT0NTUGk3TlNrSGlJcE9TaVpXTzhEUW9kNkU1?=
 =?utf-8?B?NC9hb1NLQVdBOFpaMmc1MCtmZ2J2M3l1Uk9yR0U0dU0vM0drRDgzVDJTK2xT?=
 =?utf-8?B?cmtWWVZvTTA3WUpUWGd4OWo5WEFrTXRaZm85SjJSeTR4Tk1BeVFiU01WbVN5?=
 =?utf-8?B?WWFldFlobW9XU0xKUnhaVUI2R2JNQStLZllTaCtpU0xuSy9LVy94RHByQm5i?=
 =?utf-8?B?NHF4R1c4ckgza1RWdHpzNXJlTXdxYUhyMWZrNjhCVHVNMUNWT1h2OWtMVjBT?=
 =?utf-8?B?eFNDT3JxOGlScHRPeWlGYTdrR1UvTkRQUHR0ckR4RjFPaXFRWGxPWlVXTng3?=
 =?utf-8?B?Q1BhUlg2WVdjOEE5cHgyQ3RYS3JJYXZmZ2FCODVYTDUvOFdEQ0h4bS9Bc1M2?=
 =?utf-8?B?L040NHk1MHkyQ3dvazE3bzJuOHpKbHVUOXNXZmhkQ21HaFNBUndCSWlIK3M0?=
 =?utf-8?B?N3RwdXdZM2sxeWtFZkVxcWd0OUxiV0RhaVZ5NXdnTTZ0MDcySHVCdkx1b1F0?=
 =?utf-8?B?OURYVW9qaVp5VWZNcUdUWDR1ODF2QTZXN3E4Ym83MktxUjZDUnMrMXdLR2Nk?=
 =?utf-8?B?WVFFSGFmOENDMGovU2lsNGZ4N2tPUkwyTjVIR0wxSUZkZ0NuaGM4aExuY3A3?=
 =?utf-8?B?R3pha2c4bFZoVTJJakdaN1FIOHNiaktvbkRYOExUcXUyaTZja0xoZDYxT3ha?=
 =?utf-8?B?VWN0S2lNUXVnUFhiNFRSVWVlYVdhTmlRMFRqVzY0MUsxaHRoOUdxV3VkY0ZS?=
 =?utf-8?B?WEIycUxjTXlYaU9zQVdkUVNYRWJkVGtzU3VGTjQvMFNWQ1ZRQzJLVW42T0Ir?=
 =?utf-8?B?Ynd3OWpLVUc2bkpad2RkVU5kUnRuSjJxRGlSUE5KVERRU3NkR3dQNEp0enJD?=
 =?utf-8?B?VVhJU1lZWDhUS3FzZjJHZGhqNFhSZEhlVWQ2blJWRmVmd2VwS2pxL1FTWE4y?=
 =?utf-8?B?cmM5SXZTdzVRZnU0SWxlQnViN3MxNTUyaVV2OVRNMnN3enlnd3hsUHJSMFlv?=
 =?utf-8?B?N2M2MWovdVFjNXhYMThzZjN5Q2xqUno2TU9oOFphWW1hNXFTQTc0SmZVL2lv?=
 =?utf-8?B?ZDBwVEliWk1NT2o4NmFRT0svcDVaSWpYRk1mZzRuWDI0SC8rSmFIL3ljMjll?=
 =?utf-8?B?WGNHL3Z1bDljZkZ1UjlJMnd1OXBIbElBdnBSWENGcDdxSEZUY2VyQWdQMGxF?=
 =?utf-8?B?L0pvTXU2N2RRTFd3cUlCc3h4cGpGckk0SXloQjlXTjlNTnNaZldVMGZNRUZU?=
 =?utf-8?B?Ung2MTkxbitUV09KaGU0RHArOW1WOG01ZHVkZ2NPbmJWZGQ5NW5DQnB0MnBi?=
 =?utf-8?B?TEd5MUxTZHVrTTBPMHZhcVBpK1NNK2IwNlRDY3lMNTl5bUV3am9XR1FmT3Vh?=
 =?utf-8?B?ZGVyVzYrenNaT2tMRms3SHZuV3Ixb3lYdU5vTHJxS1JDV2lMNlN4VWdDOTRh?=
 =?utf-8?B?ejZjOFozQXFQYXFZNkJIUmdLL1BQdDlsZ1JnTEF5ODRoL2lNdlE4cSs3V3Mz?=
 =?utf-8?B?U0FlUXVzSTdlc0t5RmhlV1Y5RFdONXZONmYyWXdmRHY2eHVTbjhqS2VMSjl0?=
 =?utf-8?B?RllyM00wbFc1eEl3UHNiSm1PVmQxb0pkeExqVDVvd1B1WlBOa3hFTWkwTnVI?=
 =?utf-8?B?V0U3RmE0TXM3RzdQdUhCRkN0QzYzMFZuc1RKd2owVXRDekE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm9RT3VTZGxkVVNQRWpyTWFWd09PQTZYMnk5V0Y1S1hsY05sbmlkVEI5R1Zp?=
 =?utf-8?B?QS80L3JpZU44SmY0TWhFcXhlQnRIOWRmYWdrRGp6K2h6ZXRHbXljck5hUVV3?=
 =?utf-8?B?bUNNRzBvc3AxbWhxUWNKWEtUSmNoRWhaL20yRkdhTldKOGtETEtzNnFpNDJX?=
 =?utf-8?B?OGdBY0srYWFqUXVFc1k2OUVMd3d0cW9lT3NpbVordm9DTW9YcCtyTE16ZlFm?=
 =?utf-8?B?TnpXeU9qNUsrckFYOEttMXlnSzAyN0lVWVhQK09ZSmdYZ3RiMjFPZWNJckNI?=
 =?utf-8?B?dDdvRHJHbS8xZlE1MkwrazAwSmVXOHlqbm9qZ2ZTeEVqVXhaRVg0ZUNIUnJE?=
 =?utf-8?B?dmlzQTZPWktJa1NYblFhN2pVMGNtWkF5ZUl1Vk1uUlZQcFUyY1B2N013Q3hZ?=
 =?utf-8?B?emc4UzlYU3lhMXdCYkdob2FYMy84MVAvc3U3cVhVT1JrbzM1R0F3NUlQOUR5?=
 =?utf-8?B?WE1CTjIvZlJrcklLUmR2ZDUzb21SbjJGWGFpWmhmMnlIVW5mUW94UTVkM0FE?=
 =?utf-8?B?QVZVRUhLSVVGcG1tWWxCSEVQZGdKeUZNNmYxdDJBRGlKbU1MTnMxUFFqRUU4?=
 =?utf-8?B?VlFmV29lSXU0RUNpNjBmSno2Y2hpOHdjQ0dRMEp6WElIeWNLY3lmRG9aMW1x?=
 =?utf-8?B?QkFoeWNXc25FalF2ZTQyUVZ0QkhLTnpQK0hlL0oyY1NhS1RaVjUvNFgxaDdy?=
 =?utf-8?B?d1pWbTVQWjlDY3hiN1pwSFlQRVJycEFYVFMwS2JQVlBVQmdQdjRKQ2x2Y0NO?=
 =?utf-8?B?N1Y3N3NqamQ3M2U0aHpncWt1MVJSUkxJTDBwMG9FUlBvM2lpVEZueUdMdzhC?=
 =?utf-8?B?czRKUmVWZHQvNGowbC92UkkwSHVkZWwwNW9BSnd4UkMwclNHcXdlckgrRWdj?=
 =?utf-8?B?VGdVaGNQNlJBUTBqUVVCM29xOUFNVEFMdXBWR3YyR09wakJ2UktzY3RzV0Vw?=
 =?utf-8?B?NzUxNk5NZ3NCdFBuQmNWRDlIdDcxSklFOTJMUWZNOHZtT25TUjMvUkROMVMz?=
 =?utf-8?B?N3FvdFNweHBoeFRCVHNnaWd1S2piWTZxd3MxSDBFQkovcER3SnRkeVd4TUsy?=
 =?utf-8?B?TUxXd2tjYzFuNGJyWFF0NmxHSjdmZlVqdDZGdXZSL3lFc2xyclhheThTZjlR?=
 =?utf-8?B?OFkyV3p4emVzTjRHd0MzSW1PTC9wVXVONG83SnAvMXdjSC92NUY1M3kxZTZ2?=
 =?utf-8?B?UlhVYW9HY05qQmdrb25PbUJHc2VtYWdIRkI1NGFvVDMwK21MbFNRR0N0c0Z1?=
 =?utf-8?B?SFR4Y0lZbkNoU1IvQi92c3RQeDF2K2R6QkdndGtmeENXQ21qdFFCT3dnZXlR?=
 =?utf-8?B?cmdYR0hEVVByc0xTc3JjTWxsa1pwUTdyYjcrSmhtZDF6aTBYbVU5c1hnMUxU?=
 =?utf-8?B?YmV6djQ0b0JCQzVyeWJwaEttNFZTa1B5b3gxRi9UNVJQRFpOQW1FdmUzd2Jv?=
 =?utf-8?B?WUNhZ0VValI1Y2wvL0hUWkZvUkQ1NGo5NXNJeElKZTIxem9TRlpJdEJodDg1?=
 =?utf-8?B?R0tGZS8rUy9ZSXFLbG5PYSthQ28vdXRqaEl2MzRrVkNNZFhGRWJiSkZmaEg1?=
 =?utf-8?B?REtKdWtzakpsV3V5NURSQk1tWTRVRWlkMXJEQjQ5a05FM2U3MGtaZWhNVGpD?=
 =?utf-8?B?d0ZFZFZXb09pQnpUWjNhSHhHVjhLckZJRTl4RHhxdkJVMzZhc2JzWE5PZ2Fu?=
 =?utf-8?B?QysrYW5jR0wxNkEwRmttb2Q5aUR3SG9rdXU2RzRER3YzaFpLTGY0aWVCdlM4?=
 =?utf-8?B?UmI3L2pNVmVMR0FWbGRaRkdTY3dTMDRPWWZYOW44Y1ZpZGpTU0N0T2FyMVJv?=
 =?utf-8?B?bklydlRuQkNXZ0pVMkorQUZMSVFxa3dBL0JUaEpFUXNNb1dlUmpKQUpDd2da?=
 =?utf-8?B?U3FUWkpqRUJUeGhiRlczZFNUcTQ3bitHcFRDS1VzUDNETzRjQmdHWEw0Zm5h?=
 =?utf-8?B?YkxiRjYva2hrb2piUkVSZjNjN2U3MXZWU0FpRDlNUWpVQUVjcXRPYTVCUmVR?=
 =?utf-8?B?cXIrNTl2NHZvcVl1MmsyVDkwU0ZrMVZ3MWRKWGM0MG9uYytudWNTMlVZY0kw?=
 =?utf-8?B?eFNpVlpZMUI1cE82YUM0amcvYkhBcHFMVERUVTM2VDdKc1FjdUN0RER2SnhW?=
 =?utf-8?B?N1hLbG1NMUVxY3JzSGhJbXZGS1BHWFN5Y1BFbU9nK0ttTlBIN3BYemtzWkRx?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE930157C451014798D4516506C578DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5284.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c11fcb-f19f-477f-5f33-08dcbc6c2e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 14:20:00.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/GbOpUwoDrpIKevB8agOmz5cK+7LqVvTqXMoWIrzUHL4n8eDqbbkeJ0GV25MYRuXRFmoE9uuBQzMA3bkKKBtHurMmMcXMEJjby/ueKoNAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024

T24gMTQuMDguMjAyNCAxNjo1NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+IFdBUk5J
Tkc6IHBsZWFzZSwgbm8gc3BhY2UgYmVmb3JlIHRhYnMNCj4+ICMxMDogRklMRTogYXJjaC9hcm0v
Ym9vdC9kdHMvbWljcm9jaGlwL2F0OTEtY29zaW5vX21lZ2EyNTYwLmR0czoxMDoNCj4+ICsgKiBe
SUNvcHlyaWdodCAoQykgMjAxMiBBdG1lbCwkDQo+Pg0KPj4gYWZ0ZXIgdGhpcyBwYXRjaCA6IHRo
aXMgd2FybmluZyBkaXNhcHBlYXJzLg0KPiBZZWFoLCBidXQgY29kZSBpcyBub3QgY29ycmVjdCwg
aXMgaXQ/DQo+IA0KPiBEbyBub3QgcnVuIGNoZWNrcGF0Y2ggLS1pbnBsYWNlIGFuZCBjb21taXQg
dGhlIGNoYW5nZXMuIFdobyBnYXZlIHlvdQ0KPiBzdWNoIGlkZWE/DQo+DQoNCk5vIG9uZSBnYXZl
IG1lIHRoaXMgaWRlYS4gDQoNCj4gSW5zdGVhZCBmaXggdGhlIGFjdHVhbCBpc3N1ZSBpbiBhIGNv
cnJlY3Qgd2F5Lg0KPiANCj4gDQoNCk9LLiBJIHVuZGVyc3RhbmQuDQoNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNCkJlc3QgUmVnYXJkcywNCkFuZHJlaSBTaW1pb24NCg==


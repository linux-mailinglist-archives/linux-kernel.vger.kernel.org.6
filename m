Return-Path: <linux-kernel+bounces-565214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92FA66377
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874F2189CFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7954A23;
	Tue, 18 Mar 2025 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EWFPwlcw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="by1Ev65T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V/0IxIC8"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9650184E;
	Tue, 18 Mar 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256764; cv=fail; b=goukQGhkL+me4iUQOOrfBVNMaPiP2ApM+Uul2MuPVsN6tY6peGH0wqH8GwKF6h36+5ZhkSABnQwaT01YRnA7A1U+sNGfADHJqXOt36NJwwSmwlMvEOiMRN91lmlpJpHwPLnW4ehW+5hGQ+YN98vzi/9EpuEdVz6KJlXDg7OhezE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256764; c=relaxed/simple;
	bh=DvM0ywzVIqeOBB0qqoxiyx0TxR1NBsue5+WQk4eQltQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oe5bRcpl31FgCJ7iBKmCxH920MQPZWyA46zxFSEjMNGqxP3Ki+O+hx5IjI11DDg4f8Yft3XC/N2qHr3z4hjZ+RJJAW2jh3mWK/KZtqa8NePC+QwZkqFBSEKg+pPgQa2OurXpKvCAuECZiFLHnz5YzKtVsvRj7watZr8Nwdw6Md8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EWFPwlcw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=by1Ev65T; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V/0IxIC8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HN6Tot008938;
	Mon, 17 Mar 2025 17:12:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=DvM0ywzVIqeOBB0qqoxiyx0TxR1NBsue5+WQk4eQltQ=; b=
	EWFPwlcwgwJEt+5e2bOy5RjvyBhb+J7FFhKap3wG2jlR+Sywq6e97gSkqwxUjtpg
	l8gUtJ/G/G0WqPqaWENwxyrRH6PDv0A+Fl8oEZs1nRo7okPailQbn+KjQ/58EAPc
	Hr10XJEn2MsJZYjlpHQ2aAxiN+r2NOAoeBtiwXyxvmysADW4gfoixXhGCvYbruHN
	qjSxu0sDacN3CDKAKKCafyaVfD/BjOhqfo8JrvJ+bjSN7YY4oWCFFc5T7cuPc53d
	cERELGVHy+6qujYceQ4dpJaE8Kf/wfEEx0NFKwWik1fb9pCYkiW0khgPU4IGPuNp
	kCxuhhbW7rt76iB87LiWVA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 45d86ejj7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1742256745; bh=DvM0ywzVIqeOBB0qqoxiyx0TxR1NBsue5+WQk4eQltQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=by1Ev65TLcWLB5yK0UNO2TiXBBdlsXJRK25mBACCaZihy7ElMNjaLj9McFQDldUdv
	 pvdZG2OGfCa2K6ObDCAU1b9WiSqNIhx69mkP/zSRPQOzIoNKoJWuEqFTKSCIjum+Oi
	 CTC6JpRt0IQqBVz1JaYm0alRhwwS3mi1ivgwDel/EYUJHaGDp29CFzB+zpxrx8wjjB
	 pVVbMRKCM0Y66DFcCK7UVJ5zXaKtibgg+EmFPG7c5wlT6jfffXI3NRp2X8Q7UyG5rM
	 UK1HRvXrbjJBbA1O3few7vUy66/9htUhgUFHDGFgytSyCnPCm/MYN1sbAeQtrUOg9x
	 oWGqOQ+z9KTUQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A906240143;
	Tue, 18 Mar 2025 00:12:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DDEC5A009A;
	Tue, 18 Mar 2025 00:12:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=V/0IxIC8;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 50AA8401F7;
	Tue, 18 Mar 2025 00:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgOHE5BeY88jHbuB0GP0xKmYJxNQjYGTQFoeD6nYoyBkVv0kMxCpqqPg9AZ/vITLKwN/S7RAgC2FW7Rs4E3TRvCmMY8WjyhtVj9fouKhwtJEek+wJ7y1qykr0SvjxhWK9Zdq7TWEJ51ninxkBPKM816sq7THvbWma7F24z/3sK2owaNWgdN7GKRECertZWDi51LHmOZOYUzKgAcsIEdWSY7YUe04IYM7UAukD2tOGMZUYXiloj0Ocy1f9BE+5Y6qj0Rp1oJjXD7gIpBX7Spr4r546eWq5Dg8k4C5aWwzWiy1FhBIAB86CIKKBpSqxXmVKcs4GJ/moPVR7wyE/D+BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvM0ywzVIqeOBB0qqoxiyx0TxR1NBsue5+WQk4eQltQ=;
 b=Tr55hX3Atce3OEFIRZDBhQEwTb8uYiee0ryZtXLrPN4lLa6HM5yvcEwQHb/V/NpZxVJgyg5t4Q7vC9wc1uIURUbYLSk0I+KrWb97jGwdi92Kv5UuczMLaRvsG/23Ds4JN45HSvTqYBmt92HhytgDqlFH7eGF7T7x8jI86T8Yli9yPooiXVO1Ix9GnqmB/MoEVYXIU0D3RBIuN9fbM6kgyqnuKk+4EbCiYeIMfwRY3zg7sVUJW72IP3r/w+dqnYEE6LeJn8UsNdoVa7aV/sifW9tXgGBCC1fgsXmnQkl+YmB8yyBs2pZoQOuCttDDrywnQM4pVF0pictK3j/dnYDECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvM0ywzVIqeOBB0qqoxiyx0TxR1NBsue5+WQk4eQltQ=;
 b=V/0IxIC8/fl1w0tWgPU8mzckc4pRSh3YORYWGhUDwPOWooHbgAQ5x7nTQMLbNnUNrMwyilWnskzLQlLlYkXcekjAzyYIkaynKK0dKtfANxkJyhz3T4Pt/nrWHfKvyAObNuvyrMaLnliP2edkUdJa4SgXnk6HW8bJvwg/lYoyCzw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:12:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 00:12:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Topic: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Index: AQHblPnP9d0AvXdgXUGJVdEv1Rh2trNzIhyAgAO9ioCAASswgA==
Date: Tue, 18 Mar 2025 00:12:16 +0000
Message-ID: <20250318001211.tnjwfckt5j4fbvjf@synopsys.com>
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
 <20250314211411.l5taj5nysvcalfyz@synopsys.com>
 <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
In-Reply-To: <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB6286:EE_
x-ms-office365-filtering-correlation-id: 20788bd0-4a92-4be1-a239-08dd65b18a63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnNiUklUS0hrWU82c2V4aHYzdlFnWDBiRnE5TWJ5QlF4d2syYUdPS2NsWWZh?=
 =?utf-8?B?bEJ5UDJTN3hBb1BqcGNmNndKZTBGWVFWdGZBazE2QjVRTGN1d0tNVjVBK0ZF?=
 =?utf-8?B?UzB4VTlHNHh2SkpYdUVQdnhuWWwxTVJXWjlEditFVkF2WDV4bjRwcGJ5dmFj?=
 =?utf-8?B?eHhHZ2d0cXRscWdNUTdJNnhQdHE0RWU2cXA0ZjVNeGR6bFlsR0lob0tNVlpX?=
 =?utf-8?B?SWlYT0xwMG45L1VWeWpZZlh3aDZNYjM5VEpIRDZUclowOG15V3crVkk4TEk5?=
 =?utf-8?B?NjNoQkY4eVlqdEt3bFAzMXV4aHlJRlFVWFNEWTNlNlB0OFk1VTJldnRCdkgv?=
 =?utf-8?B?c3Z5VHd6THI1eUJ6WWFiVXpMdHdaTUhtZzgzMjRKSnhHblpPVlQ1Rk81SDJp?=
 =?utf-8?B?R1dTYXBibndocWZXTkZqc1VkSkcrK1hKZjlINmFhVThEb2pPQU1pNldTUmda?=
 =?utf-8?B?UzJ4bU9UZlZmcjZNZnl1ejJtVUZ0SnJkakxKcFVJMmxIR0FsVUN3NDR0RDZC?=
 =?utf-8?B?VTl1b2lrZlZCRk5xTFJVbkthcGZmZFZON0V4TFg5K3ljMVJQYVBnenBkbWhV?=
 =?utf-8?B?c3E4OFkvM3dQMUk2VzFVTHRmUjhLT09PbjJVZTI3TmsvK2o1SjBNeDEvbjNE?=
 =?utf-8?B?R0hCYUpUa1VXY1FtSEtJYmJ0aUlYckVXZWpzMzQ1ekRDUy8rdzR1aU80dFVV?=
 =?utf-8?B?RCtTL1VzUWFpVEVSTDNOY0pkVFhCQzVLOTJTcFJQODluMDF5SmJCdzE1MTVG?=
 =?utf-8?B?UXV0NGh3eDdCS1MwazRvRGFERXJpYW1EK1k0OVZ4c1FoWWlLemtQT05OS2ZH?=
 =?utf-8?B?TGdrTTc4d1R0UXh5dlZLVlFFeWRaOTU1WnNXU01jZjZzS0hBdVVSSDNkTXA2?=
 =?utf-8?B?bm9qQW1ObnRmbnNaSTFldW9qWks1K21RM2k2UEFQU0VLbURxSHIyMGtVWldl?=
 =?utf-8?B?RWNhUUN5d3B5YjFVcUdqK211bnAwUXBwVnkraE40aFZNRlZtbWN4UVpNc2Mr?=
 =?utf-8?B?WE41cGNFOFc3OTBxckUwdUorUEZQdUNseWVqWlFPM0N3MU9xU0ZJWnRxNVNH?=
 =?utf-8?B?UU5oVk1kVFRicm53dVIrTXR1S0llcFlhMnFvSVpwV3ZWeHpjcHB3eGZIUHVv?=
 =?utf-8?B?TFA3dmRoT3h0MGMwUGxrd3BTcGZwK0k5K0dMV1cycWVSSVZqWHUzczJ4LzRX?=
 =?utf-8?B?RWVpakZFcDZwclU4d2Q3TnBwS1EzclpjeTBFZXVndnVpOER2VE5aNkIrL2I5?=
 =?utf-8?B?dTdnQ1F2RU9pZzQwa3dSUGl4cjRsVzhOYWJEWTRoSlhaK0tXZUtUVzk0cVdu?=
 =?utf-8?B?em02RXhGNXhLQlIwd1R2S3ZsR29EaHFITmxVL1ZoZlRxakorK2hNREdKK1h5?=
 =?utf-8?B?eVZlMnB4eXl3QWs3dHAzRmVoc1VFZ0FNSlpZVXBRQk1neERZY2NaekZqRklC?=
 =?utf-8?B?TXR2TmdvcE1ibWZTTWZEdFRPMEFnRjM2clhRSFpsRHkxM2NUdG13cUtJUGgv?=
 =?utf-8?B?OXE3bndjcUU2Yi9rYlRQODJMZ1lHVFRwMzcwcmExai85WTJTVk0yMDlyakZP?=
 =?utf-8?B?SjVQaWVVcFBvYUFaSk52eTJ0U2ZuY1AvZkp3RkFRNTU2aUFyZU55OXlYRXUw?=
 =?utf-8?B?Q3l2U3FyUDA1UFBONTVEYkI1NGkzMW1OdDg5NWc3YVgyaXFXKzZCMGZ1S0dJ?=
 =?utf-8?B?VXpBSHZQNEJpTGVqSHgrOXhrdXpvM3dINUY5RzNUVDYzWURPdUVxdm5YcWRq?=
 =?utf-8?B?MUVwQjBUL2tEWmZLTXlIVmpaY0FZQ2t6UHJkbG13d2IwQTdiMDZGL0xhQW5E?=
 =?utf-8?B?aGdQbnlqWkU1UGZHQ1lCTVNWY3RSWC9qMDRuWEdLQjBsdWgwcXZCUWIrQ0Va?=
 =?utf-8?Q?2WEQpdhYamkca?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU9HaEJTNGpyOHFrR2Q5ZXBQejJHSW01MmdJUFZwRThlaEU0cWhhREpYanhQ?=
 =?utf-8?B?NjBYNGs0eXRBemI2a0RiVHd5Yms3UysvZU1QZ1BVemM5UTJFb24yVHpZWG50?=
 =?utf-8?B?Z21pa0hXbFlYV1M1dzczQTFXUTNEdGNYVWxlTlRYUTNlWlU1ZHlkb1NqMENT?=
 =?utf-8?B?NW9CdTdYM3drZU16Ym1MWTVTektEaEx0RGlVaDcyMjFNMEk5WkNQWlZqcGtI?=
 =?utf-8?B?RCtCUnhxTGZHUFlHM0grcWl3YWFML251SHVNRHNNYkhINHd2U3FoTU9iaWl6?=
 =?utf-8?B?RmMrOElpR3A1a2xEZVh3WGlqUnhBMHg1Nk1IK3NLSzROckNMMkdSWkRUUkFj?=
 =?utf-8?B?MWFMdS8wZG5oSTVGaVhlcy9INlkvd04vNGNzSXJ0SnRqcGlmRSs3YWxnSTBk?=
 =?utf-8?B?VkhuVzh6WFN4eXdCL3I4dUlVbnVWMHRGeXpabDEwTG01S1k3dmRaejB3UjUx?=
 =?utf-8?B?Ump5SHhnQ2FWeDdPejNZY2lZeUI0ZngrRnpldnI2V3hxTjBUeXVXTzQ4MU01?=
 =?utf-8?B?YXJDQjlHenhsWWFLQ05nS0toN3J6Y1VTY3dXVGVWRkRhaTBuYnJQcU04WTd4?=
 =?utf-8?B?T3NXOVc2dXRsZmJuTXo3a0o1b3FDTWlDVDdwYkE1SmdIZGhlWm01bFl1VnZS?=
 =?utf-8?B?TkNjdWZKUzhzV1c1VzlEOVNVZGFqdFZaeFcwVWtIOWZHWXZDSzB0Y2trbWY2?=
 =?utf-8?B?SjNzMFg3ck9Xb0J3Mjd0M2pxZURGdDNpUHRYRWhkNHhsZnlmOTJhb29DRm5D?=
 =?utf-8?B?cHhER2pwSzN3WExtNkJNd09FNW9ZRDM2TGE2ZGVLejlVcUhrc3U5VWVUTjN0?=
 =?utf-8?B?TGVsRmZRMjc0dlpmNmJGVXlnTUluellzT3hjR1l5MlpPUUhHeERuL1BuRFNl?=
 =?utf-8?B?Z2pyNzJuMFZyWGdtbzVVc0MrUjZyUG1uenFhb2Yxazl6bWFsSlFZUVpVSlhk?=
 =?utf-8?B?bnBtS0dFc081M2Zxc0kyZnF0V1RRZzYzZ1NwSCt2aGpxS3N3Z0Z1YWpZWFBC?=
 =?utf-8?B?cUNRUktLc1lRVmtYSllKZG9UaWVVMVdwMnllWUE4UVpEVnd6ME9QM2hxSnFS?=
 =?utf-8?B?bmpZODgrTWVFV01oVTl2aXhrVlRKa0FFK250N3RzQnBCNEtmVnJaVk5ldDBJ?=
 =?utf-8?B?Q1ZZQ0ZPWmwzWm9LS3kyQ1FQYk5Gb0pLVjU2YkE2UDZIcWFaMDhhT3p2Q3Ji?=
 =?utf-8?B?eThaV1RQenFML21VUlllcHVzZDE0VmNscWt3STVyMHNUeTJVcTNmU21paXVq?=
 =?utf-8?B?MTA0TjBFcW14cXhreUpZeVBjeXM5YWFDREFnZHZ1UEptT0dMUHcvMVJsajh0?=
 =?utf-8?B?cWpBU2Q4WHZiMDY5b1dDSnhWaVU3Sm5Fc1drSzl0UUxTWHA3SFljQlQzRFI4?=
 =?utf-8?B?SXYvdytoTWw5bFMybGtIc0FjOTRHdUlFT3dIUjhzN2xhalhmK2dHakttaDBI?=
 =?utf-8?B?T0xZdXR5SkhCZnNJc3BlVkxqWStqSERIbzdUc3I3Ny8rZTE3VjFaRjUxQzE1?=
 =?utf-8?B?UEo0cDNML1lJd0lnZ2NrNHdsb1ZraWlMRzJQRVZnMUhWTGt6YmIvOGtlOEdy?=
 =?utf-8?B?K2ZXdXB5bE93T09OL0hUSEhJOTZ6RlQ3U0tha0VXcWp2N0lidys5S2RnN29w?=
 =?utf-8?B?Q1NibE5acUFETzhGbTRLMVI0aG9tOGdEQzBqL2dxY09RT0RKRnhyMFRGTTE5?=
 =?utf-8?B?Q3JLWFBmQklKK2ZkWnAvZzV4UmI2eXVWaEZ4UzEycmQwRVJlU0ZsdFZHYllo?=
 =?utf-8?B?VTJ3VkpjcjdlNVhYTTdNeEdSMDVaWDZOQmxUV0Y3UXBMaUdua1BLb3duSXQ4?=
 =?utf-8?B?WlcrTG5QZnJZY0pFWnJiWmtlWXZwREE3b2VBRHdlRFNwNXpDZzZiQ1p2Qms2?=
 =?utf-8?B?ZEE1RUo4WVI5bDBWN1FxeU1oSm0vRnBDb1lHNFpnYVdINUtrSUtyY0poK2xu?=
 =?utf-8?B?RFRFbGh0QWJXNTBVNUNrYUlpYjAwd2FGc1N2dGZvMVlLRDJJZDdRazR6NDhk?=
 =?utf-8?B?ZUIrVkhNR1pzdDlpV1dYOG84d3V2SWlnMHdVclh6RFdVRHJZZ2QyTm5IQ1Bw?=
 =?utf-8?B?eWhTVCtQd2dnL21XTG9uVWJ4Z0J6YlRJNzlmUmVOczh4elJDSU9MaDJ2M3Fw?=
 =?utf-8?Q?c4FtuLCJOVZZWgzWHg8VhNnHG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D705705AE60A6448DF8C6AEFFC777E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1S9FXxrSRqyVG8KQOhxpzgPwlp+CBEzxWisUHH5dS6PYLHnRx4y/3yOL+8kPdyRiKrgMESOQguWBDYusJT/HY9ckwzPbQfFyjSMi1MRg4IIoV3YaV573mgGW4+SsXs76zdUu88LOj21ALDXSK0iCyj4Yqwd+sMyGUHMFKUYc8FPojwYRmUfO6mZ+zV/MAFhr5FZbxwnkihWPV9ed/vFhciNXSL90n+lqu+no79ggycwXFiwbBP5qdLq/KcUF7lyqqCQlnsyR3Peh9FKK5GEbUkK4ED6zeinaYshTHCHg5dh+Jc8yaKs/7Z3PiYoyI0oz3vZR7mhHf6di6m00bcdVZW1BcK8XIrXgICd4b3wi7HWIR7KpmIneIfzS7MwrwbeNER3bPxePK4wUWh+SBpNhzlVUdkYLpWQ77Wuy191iY3HrOsXZBdKlhTHZY400PyZQLjBfMqMgbXx7feOPb6hUWVIMCSqYfAfQHQbpUvngTdkWyoOf7sfXvHUHArDNMRAS1CkETLN/jJ0nls4mEksfLkvi2lw2Ubgs6UhO/k3+eFmOjUT4solGcxl0D9oElxKUp9NfCOCp57NpUg7opZjyPKehKTP/SrMxEXR73osPgCqyQEnQAKVnV5yjqulpilLKIBpLDnz+cWjMNlvF6XR7XA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20788bd0-4a92-4be1-a239-08dd65b18a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 00:12:16.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yWf08IxeDatekcZMvd3bjoKd3kCJ1OiEHDSUru1Swrwf5xfFONV2Tn2ALPBztMhgNBYnRWK6JvEy3mbBdsQ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
X-Authority-Analysis: v=2.4 cv=fcaty1QF c=1 sm=1 tr=0 ts=67d8ba6a cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=Z6EfDJrRAAAA:8 a=rSxicxZVIFUPUYCaznUA:9 a=QEXdDO2ut3YA:10 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-GUID: -m_8tu2mZ_CZhMqbNlWhZEZ7IZPgd_XW
X-Proofpoint-ORIG-GUID: -m_8tu2mZ_CZhMqbNlWhZEZ7IZPgd_XW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1015 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170176

T24gTW9uLCBNYXIgMTcsIDIwMjUsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiBPbiAxNC0wMy0y
MDI1IDIyOjE0LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJpLCBNYXIgMTQsIDIwMjUs
IE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiA+ID4gU2V0IHRoZSBncGlvIHRvICJoaWdoIiBvbiBh
Y3F1aXNpdGlvbiwgaW5zdGVhZCBvZiBhY3F1aXJpbmcgaXQgaW4gbG93DQo+ID4gPiBzdGF0ZSBh
bmQgdGhlbiBpbW1lZGlhdGVseSBzZXR0aW5nIGl0IGhpZ2ggYWdhaW4uIFRoaXMgcHJldmVudHMg
YQ0KPiA+ID4gc2hvcnQgInNwaWtlIiBvbiB0aGUgcmVzZXQgc2lnbmFsLg0KPiA+IEhvdyBkb2Vz
IHRoaXMgYWZmZWN0IHRoZSBjdXJyZW50IHByb2dyYW1taW5nIGZsb3cgYmVzaWRlIHByZXZlbnRp
bmcgYQ0KPiA+IHNwaWtlIHRvIHRoZSByZXNldCBzaWduYWw/DQo+IA0KPiBJIGRvbid0IHVuZGVy
c3RhbmQgeW91ciBxdWVzdGlvbi4gV2hhdCAicHJvZ3JhbW1pbmcgZmxvdyIgYXJlIHlvdSByZWZl
cnJpbmcNCj4gdG8/DQoNCkl0J3Mgbm90IG9idmlvdXMgdG8gbWUgaWYgdGhpcyBpcyBhbiBlcnJv
ciBpbiBYaWxpbnggZG9jdW1lbnRhdGlvbiwgdGhlDQpkcml2ZXIgaXNzdWUsIG9yIHdoZXRoZXIg
dGhpcyBpcyBmb3VuZCB0aHJvdWdoIGV4cGVyaW1lbnQuIFNpbmNlIEkgZG9uJ3QNCmhhdmUgdGhl
IGluZm8gb2YgdGhpcyBwbGF0Zm9ybSwgaXQgd291bGQgaGVscCB0byBrbm93IHdoZXJlIHRoZSBz
b3VyY2UNCm9mIGVycm9yIGlzIHNvIHdlIGNhbiBkb2N1bWVudCB0aGlzIGluIHRoZSBjb2RlIG9y
IGNoYW5nZS1sb2cuDQoNCj4gDQo+IFRoZSByZXNldCBzZXF1ZW5jZSB3YXMganVzdCBwbGFpbiB3
cm9uZywgdGhlIGlzc3VlIGlzIGFsbW9zdCB0aGUgc2FtZSBhcyB0aGUNCg0KRG8gd2UgbmVlZCBh
IGZpeCB0YWcgYW5kIGFkZCB0byBzdGFibGUgdGhlbj8NCg0KPiBvbmUgZGVzY3JpYmVkIGluIHRo
aXMgY29tbWl0Og0KPiBlMDE4M2I5NzRkMzAgIm5ldDogbWRpb2J1czogUHJldmVudCBzcGlrZSBv
biBNRElPIGJ1cyByZXNldCBzaWduYWwiDQo+IA0KPiBOb3RlIHRoYXQgSSBzZWUgdGhpcyBoaWdo
LWxvdy1oaWdoLWxvdyBkb3VibGUgcmVzZXQgdG9nZ2xlIGluIG1hbnkgWGlsaW54DQo+IHNvZnR3
YXJlIGRyaXZlcnMsIHRoZXkgc2VlbSB0byB0ZWFjaCB0aGF0IGF0IHRoZSBYaWxpbnggYWNhZGVt
eSBvciBzby4NCj4gDQo+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlrZSBMb29pam1hbnMgPG1p
a2UubG9vaWptYW5zQHRvcGljLm5sPg0KPiA+ID4gLS0tDQo+ID4gPiANCj4gPiA+ICAgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMyArLS0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXhpbGlueC5jDQo+ID4gPiBpbmRleCBhMzNhNDJiYTAyNDkuLmExNTlhNTExNDgzYiAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ID4gPiBAQCAtMjA3LDcgKzIwNyw3IEBA
IHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnByaXZf
ZGF0YSkNCj4gPiA+ICAgc2tpcF91c2IzX3BoeToNCj4gPiA+ICAgCS8qIHVscGkgcmVzZXQgdmlh
IGdwaW8tbW9kZXBpbiBvciBncGlvLWZyYW1ld29yayBkcml2ZXIgKi8NCj4gPiA+IC0JcmVzZXRf
Z3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJlc2V0IiwgR1BJT0RfT1VUX0xP
Vyk7DQo+ID4gPiArCXJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJy
ZXNldCIsIEdQSU9EX09VVF9ISUdIKTsNCj4gPiA+ICAgCWlmIChJU19FUlIocmVzZXRfZ3Bpbykp
IHsNCj4gPiA+ICAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIocmVzZXRfZ3Bp
byksDQo+ID4gPiAgIAkJCQkgICAgICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBHUElPXG4iKTsN
Cj4gPiA+IEBAIC0yMTUsNyArMjE1LDYgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfaW5pdF96eW5x
bXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiA+ID4gICAJaWYgKHJlc2V0X2dwaW8p
IHsNCj4gPiA+ICAgCQkvKiBUb2dnbGUgdWxwaSB0byByZXNldCB0aGUgcGh5LiAqLw0KPiA+IERv
ZXMgdGhlIGNvbW1lbnQgYWJvdmUgc3RpbGwgYXBwbHk/DQo+IE5vdyB5b3UgbWVudGlvbiBpdCwg
dGhlIGNvbW1lbnQgbmV2ZXIgbWFkZSBhbnkgc2Vuc2UgYW55d2F5Lg0KPiANCg0KVGhlbiBjYW4g
d2UgcmVtb3ZlIGl0Pw0KDQo+IA0KPiA+ID4gLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJl
c2V0X2dwaW8sIDEpOw0KPiA+ID4gICAJCXVzbGVlcF9yYW5nZSg1MDAwLCAxMDAwMCk7DQo+ID4g
RG8gd2Ugc3RpbGwgbmVlZCB0aGlzIHVzbGVlcF9yYW5nZSBoZXJlPw0KPiANCj4gWWVzLCB0aGlz
IGlzIHRoZSAicmVzZXQgYWN0aXZlIiB0aW1lLg0KPiANCg0KQnV0IHdoeSBkbyB3ZSBuZWVkIDIg
Y2FsbHMgdG8gdXNsZWVwX3JhbmdlPyBGcm9tIGp1c3QgbG9va2luZyBhdCB0aGlzDQpoZXJlLCBp
dCBhcHBlYXJzIHRoYXQgdGhlIGZpcnN0IHdhcyBpbnRlbmRlZCBmb3IgdGhlIHJlbW92ZWQNCmdw
aW9kX3NldF92YWx1ZV9jYW5zbGVlcChyZXNldF9ncGlvLCAxKS4gSWYgdGhpcyAicmVzZXQgYWN0
aXZlIiB0aW1lIGlzDQpuZWVkZWQgaXJyZXNwZWN0aXZlIG9mIHRoZSBleGlzdGVudCByZXNldF9n
cGlvLCB0aGVuIHNob3VsZG4ndCBpdCBiZSBzZXQNCm91dHNpZGUgb2YgdGhpcyBpZiBzdGF0ZW1l
bnQ/DQoNCkJSLA0KVGhpbmgNCg0KPiANCj4gDQo+ID4gDQo+ID4gQlIsDQo+ID4gVGhpbmgNCj4g
PiANCj4gPiA+ICAgCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVzZXRfZ3BpbywgMCk7DQo+
ID4gPiAgIAkJdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAwKTsNCj4gPiA+IC0tIA0KPiA+ID4gMi40
My4wDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gTWV0IHZyaWVuZGVsaWprZSBncm9ldCAvIGtpbmQg
cmVnYXJkcywNCj4gPiA+IA0KPiA+ID4gTWlrZSBMb29pam1hbnMNCj4gPiA+IA0KPiA+ID4gDQo+
IA0KPiAtLSANCj4gTWlrZSBMb29pam1hbnMNCj4gU3lzdGVtIEV4cGVydA0KPiANCj4gVE9QSUMg
RW1iZWRkZWQgUHJvZHVjdHMgQi5WLg0KPiBNYXRlcmlhYWx3ZWcgNCwgNTY4MSBSSiBCZXN0DQo+
IFRoZSBOZXRoZXJsYW5kcw0KPiANCj4gVDogKzMxICgwKSA0OTkgMzMgNjkgNjkNCj4gRTogbWlr
ZS5sb29pam1hbnNAdG9waWMubmwNCj4gVzogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly93d3cudG9waWMubmxfXzshIUE0RjJSOUdfcGchZTQ1QjB3RDVkdkI0TlY4Z3o1SmpJV2FS
VFFyWDlNMnVFMG91b0JWWDRUUUM4c0txdFlSTDhySlkzeTJiYjA2MWd6U29HTDBGT1BKdi0zLWFk
a1AxYjNsZHpSWm54ZFkkDQo+IA0KPiANCj4g


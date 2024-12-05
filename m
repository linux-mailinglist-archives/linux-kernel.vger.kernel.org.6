Return-Path: <linux-kernel+bounces-433106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9A9E53EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48BB286BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A5207648;
	Thu,  5 Dec 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="iIiwmy3b"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3C206F24;
	Thu,  5 Dec 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398117; cv=fail; b=TnMGdUStDDaaKIdWZomOn1aepbau1jxaT71gFV1XAHGOtrruipVOPPBwAeKE/h8uYxp4ykZ6wk1fgwBZSGUJJTXUuVZBhtmQixxwNANpc1f9BCKQ/plD2qiGhpu+IGl/lnupXMEMA6nqOzTTLg4yLI7LlW/CwannhoKcJKiVRwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398117; c=relaxed/simple;
	bh=d1QTDkZlAFeUlPSNpUjw1Stfd5EnquVsq5tJ69dq5+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/C6ZRNkIFm4+xIz9gQboJ8d9Q6eJqN9zY1owzSKp6YvuT/Ok91qrb6T/BzIk3R8oyvGkrtI3adlDs56BYSTE2k4UeRhdQIBiP1wV9wtEJNlB67/WH/xubQpeFfOKP9f7qoRQyiQREQDj9+iAzK+tG68B3+5Y4yCFqpX+Ntqefg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=iIiwmy3b; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59tQNZ001982;
	Thu, 5 Dec 2024 11:22:28 GMT
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazlp17011024.outbound.protection.outlook.com [40.93.131.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 437rwvt8vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 11:22:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dau3X8UUFMbGqVxVjFGbPsIFdvwNiO+wHTMxqlrUTtfdg4nbPZXmEstFWURe/WigzILxUp5kisMBGz4Uq59ld4ipGsGh8Uf8NgK7zFT135Q3fuNbXxhseMX7aCuR68a3xO1UaZNspcU0Id49CdFdGyelcSBPHQ0VoCIjNg+E6FWbD6UMeINbHuMrlJsV1PDtbRIFR5dNIeG4XDoHTrWfKq925lnzR11MMfQBYJZV6Mcr1zscH3sxXuWRi8VmhhJeuKHeaRsd9vQVuavEFbLhSp3GQx7fHBiL8O1Pz3g9Gfi51QvUi/CncCOIUoWwkO2mZvp7Zd3LjnFGduOaFTemrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuXu869Udyx9pkRMYyRkMYgY+Ko+R0RKG/83PHJmTBA=;
 b=poOgpcEB1kLgdCqN1AqHiFJ5O53Q+3cCB4/ub645cL8akeulnXJoyP6Fhd05+6OR1QaMv7oHqTuVZ6iJRP71lTgHp1hHPBP/xJuz8/+NZjn/lFVhiajbdHO/+edqltWAVcidaEl8jDL3+paxHKF8AQnpSZhDHryWtQ+VPMizXpmq/wV6D2hymq/g41Pr1xQ0TkHUmMdvuLoB95zfEnt1gF9QfpCQDy9wEPd9KZM1Jp7jkvOP9IBl6rtO7xLZgWCDc7HdPyAQnAfQIL9LBRGJqSSk+4f0qGqmxsNl2eD2TMJ8exRSbJEzOjsAUP0pm0jX69T94ME6R2xHG02DHqnBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuXu869Udyx9pkRMYyRkMYgY+Ko+R0RKG/83PHJmTBA=;
 b=iIiwmy3b3umyGTohwmKiMBsbqKjL6DbibOrmggeVLZ1+2IyKbBu/D9u+570+WMkkjHx9Lu0kSe4Aevh/yWfel2um2Qq1a+yoFo0ngxtQmFqGj4UbXbBrHjnAgAY52rLGnvsut3NxvDtNSFxRIcY2SEpGe7/GLoQTwYQoyxKsHMM=
Received: from PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9f::14)
 by MA0PR01MB6859.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 11:22:22 +0000
Received: from PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::25db:9dbb:c75c:2745]) by PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::25db:9dbb:c75c:2745%3]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:22:22 +0000
Message-ID: <ac96f306-e5ea-4514-b25d-18b44777d3e6@blaize.com>
Date: Thu, 5 Dec 2024 11:22:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Cowgill
 <james.cowgill@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@lists.linux.dev
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
 <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>
 <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
Content-Language: en-US
From: Matt Redfearn <matt.redfearn@blaize.com>
In-Reply-To: <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0556.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::6) To PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB7694:EE_|MA0PR01MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9c515e-457c-48b9-5cb3-08dd151f1642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1PSWxScFFUSnY0bjh6c1NxWUQ4RXFCTWJLbVN6TEdGaTRhVTF3dlNKTFJF?=
 =?utf-8?B?clpaTnFEZlFRTGdldGpiOElKcDd5UXVrSWJnbkl3UEVNT0hSREV1M01Nd3Vp?=
 =?utf-8?B?YzZuRGF0VXVrNmtIRStLa2ZKYzdycXNYbEUvaGlMN2Y4UVFGcVVzM0h0U0JB?=
 =?utf-8?B?SWF2SDJhVVRBWllWN3I5VUZ6eEZaNCtJZExVcU5Ldi83WnRzanYrbUJybkdP?=
 =?utf-8?B?WXovNkRLMWwvRjFGMHV6Rm9rVi9VaE0vT0pzeHYrUTVkVy8vWjNKUDJBTDg0?=
 =?utf-8?B?QmMxNGZ4MDhvYzJVaE1oUFV1N1YvTUVlVVI2bzVwRW9YTVNDQnl1QzhnbGN2?=
 =?utf-8?B?dWExQ0JJbVNQRWc2OVZLNG1RVU1ROTF1Znd6b3pjWmN3QVIvL0RVZm9wVEpz?=
 =?utf-8?B?NjY2S1Jzam5oOXlrdDd1UjRiVnJlTEszNnVCbHQ1V0RaNXllL2dJQ1JVZm1P?=
 =?utf-8?B?eWdCdGZYdnRhc2VXZU96RzRjQTZGUmNaOVE1QWZrRVBnWGplQW5MdTlVVDNh?=
 =?utf-8?B?LzdEaTlTa3p5M0JzczJGQzJIL3V4NXB1ZjVmNU9CeTE2R1FPL1Z0VVZwZE1y?=
 =?utf-8?B?VWQ5SFpKNVBZcEZuZm0vcXNscHp3emRySmFpOGIzZ001OG1CY00rOTl2TUFl?=
 =?utf-8?B?UFZnSW15OXQxeUt4d3dqUEpoUjA0cklkdmlTTW5iNWdObjFvc0tnMFNlQi9t?=
 =?utf-8?B?aVNJdkhQOUxESk5kQ202T1VJTkl6VGp5cEVSb0FhYUFpK3JvVG1xRjduWFRG?=
 =?utf-8?B?NmJMNjdwMmRKLzBqZDJZZ2NNVERlYWxvL21CQWFyUWxnWHNCWDBCS3gzZkJk?=
 =?utf-8?B?UlYwMGxpNFloVTU5ZkpKVjVnOUNiYTA1azQyMWFFVUpBS3BqK0g3N1UxQnkr?=
 =?utf-8?B?bXUwMTR6MnlmdkplRFo0S3Rwc1l0RGQ1WUIzNGdoSUZIMkJRZGVJZHhOTWx1?=
 =?utf-8?B?WjArUW4vOGk1M05KTlU1bFhjRC94R0hxWkdoR01rczBTQUdHMGVhT3MxcXZX?=
 =?utf-8?B?ajRldnVaM29rSjAwVkZPeVhmS0RGWEZJVlFxd2xrN1pyTHNtS1RzSFJSTFRK?=
 =?utf-8?B?c0NlQUQrZzV4MkE0eWdjMG5lN25YK2lXWkF3eE9Kam5JUEZkWkNOZnAzdU9o?=
 =?utf-8?B?L1hlZkNYMVBzajFac1FoWXVWTmRPRG9vNmtpRXQrNUkxR2RzY3B3ZlpxdGFC?=
 =?utf-8?B?VzZQS2lsS1hUTW03K3dpbVAxQnNQb3NrVmpUY0lrTjFHdVBVRTZHR2w3Mnhr?=
 =?utf-8?B?OVBKRlZuNUlhSXhRbWpmS29GWVlqRmdwVThuMkZoczJEbWxBSmRLWW41OG54?=
 =?utf-8?B?OEJESjI3SmpWMFVoY2VIVEhJMEdQYzhSaTZ3Y3cwd211MHBYSEx5bGo2MUVz?=
 =?utf-8?B?R0hBM0R4N01ja3NrQXg5Z2FuQWlvTkUyNDV3dk9YdDYvQmM4QmZQM3VsbDlz?=
 =?utf-8?B?Y3ltcjJMNmd3ejU4angxN2grSXJVN1puNlNNTVZUZjViN2gzUEw4ZkVpbXZC?=
 =?utf-8?B?cytJSzE5SDhxaEorcmR1Vjk5QzcwVGpNVUE1b24wYUxtdVhuMk9wOWp2NGQ5?=
 =?utf-8?B?TEdqSjdPSHBrU29yYjQvbTdyeFFzVjJwMWRBTzJ1TTZldlhSWnV3S3dmeGZ4?=
 =?utf-8?B?bFZRMkNHK0dQWlpXSFYwWGJWOFZzMC9ub2prelpCWFMxbFBBY21XcDFqN09p?=
 =?utf-8?B?aWJBZCtRZngwcmhRSHhpRm9BeWxXRFJkTURHOGRPVGhDSU54anNzK0pXNEpW?=
 =?utf-8?B?Y3BoRGJoQnllNlU4RnRtY3dmdTh4R25TUjQySHZRMGxSYzUyWGlZTlJacE02?=
 =?utf-8?B?SlBQSjFEUzYwdm9TL2c2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NSN1M2ZVkxb1liNXZnN3lwNC9iLzdhdUFjczVFR0JIQ0pLNzkyeStEby9M?=
 =?utf-8?B?d0RDNmpCSEVMR1dkcFZ3S0lReWlHUzVqRHJ1cE13Y0Z1d1FoUVY4dnoySzFs?=
 =?utf-8?B?eEJ0Ri9WWnhGd3JhM2IvVGIzYUp4dzUveWpuR3JpVzJVVEFEbnRLM2NTYllY?=
 =?utf-8?B?bElHV3hVRWZ5dW5sVkNITWVteGF2VGpMekpmeGJubmtvQTRDN3pFTExIdUty?=
 =?utf-8?B?azdRN2srL1FsV1VrdDdpbVJGaDJSc2NnRVBEL1Npc2Z6aU1ydXBPeS9abG5W?=
 =?utf-8?B?dy8vcndKNDYzaHdMQUpnNUZFYmIraHlvT3RBdGZuRjRNSzhLYUhrWUJHWmxs?=
 =?utf-8?B?REh4cE92cWJVMGdvNG5xMVgrZ3VrVk5BaStYMUo1eHc4b1VFNEhaSWJIWkFp?=
 =?utf-8?B?TnhmeE9HNUdqYUovT2duVUZVVWNpR21FNThWMWh1eGx3c0VNdUNmYkw1ZzBQ?=
 =?utf-8?B?cTR4YWRURCt2a056UEZPVUV1UWlEanBpNWNodUx5RXpxWFlpSk9uUlJvWlNh?=
 =?utf-8?B?eHBVYmZ5Zyt6eE1NUTBDZGlvR3hrNHVGaFB0VTdYS1FMUnlqdHluRmh3Zk1H?=
 =?utf-8?B?NTJUWGIzUUI4anpPdkhZYzlYcFZGam1GOVh4ektKWlpZQ0dtUnBQZk0wSFNx?=
 =?utf-8?B?d2NRTFd6L3F2aVVWcTlDeVR1WnIrYXBjTmd0ekNLR0s2ZWt5Tkc5Y1JtSWo0?=
 =?utf-8?B?d1NKWEs3QUVpUFRFY3N5UlFWV3JpUkk0Q1E1OVRwMFYyS2MxRzVtWkZvdmRz?=
 =?utf-8?B?bnNqUUpZUzhwVGdEeVY4WHBQb1VFQkhLZEgwTlIvK3pIQ1VGUDAydXRwVFMz?=
 =?utf-8?B?elQvR0Q1a0NTQnBxMFM4bUlyU0dNaU9lTjlMUlVIUWZLQUdyWnJMZTlibkph?=
 =?utf-8?B?TzMzSXFzVTJwa1pYbW5WMTdpMWUzTHZEMTVPYXFZKzd5YmZGMCtsMkMrWWJL?=
 =?utf-8?B?QWlhTU93RTEwZFprQUNrK25YbnA5cVBNN1cxUnB2a2ppOHdrdHNaSWxweFpi?=
 =?utf-8?B?TVR5V2tyS3htK25wWTg0eFpkUWpndGNXczRoeWxLSmRTanJ4STlWQWI0V29o?=
 =?utf-8?B?aVdaTC9nQXBaRDNjamlENEFQRlRBdnEvbGRjWkkyVHVrT1ZVTkNNbndoT1d1?=
 =?utf-8?B?OXNWM2NlWHlTd21wNFNwbGxlOE1MV1RDRHBVb2kySmdxczdDL3FGNGVIc2Nz?=
 =?utf-8?B?YTVLdEhvODZzQ2RKemU1R0x2QVZsRDdxbGN0cWpSNGJaaHVQNzZvVzRWNGEv?=
 =?utf-8?B?WlE3NTdxYjBTcDEvOXNzY2xsemhjVzJoZVd4YmV5T1FxMGZWS1dZeDl2aFAy?=
 =?utf-8?B?OWhabml5Vm1zeWtNU3I2WkFkeVV6MUtua1BiS3VOaTZCc2k2eUZQMDBINzVI?=
 =?utf-8?B?YmlEVEg4Qk1nd3lOVEp1TGVRRGdwekozcmFhaWE1ZWtzNzlDZG5UZmYwNzNk?=
 =?utf-8?B?ajBkcXZac1pVOUVCK1o2WlBDeDFYVWNlaVBtTkFscGlQMUt0TWdkL3ZVZFlK?=
 =?utf-8?B?NzlyR200aW9lYnM1MUltQkJLOEdZL0szL0JZc2tWZzJRU0pzWHQ3a09Hc2tO?=
 =?utf-8?B?L2lUV1JNSmRDdzYrRmVkMC9Sek5GSUI1eXJ5L0xRczhSTTlXZC9tK2ZqZXlD?=
 =?utf-8?B?cU9EV2VpaWN5UGFTVlZZQk81YmRSdnZGek5sODZNNFdXL2dEeGtBVjlBQjR2?=
 =?utf-8?B?QWhJRXZXNXloOTZBeXRES3djRzQ5U2tqdGRmVXQvS0hzczhUSzVQL3VkUGtN?=
 =?utf-8?B?NFRsc2VzSjNyN29TQlh5TXIycHA2VGhWL3BLYkhJaU1kTWxVVXcyOC9Jc2Nv?=
 =?utf-8?B?cERoaHY4MHBqZnVMVjYvZ2hHOUZpQ2hJUVVyQVpUWU5INHJWSHd2bTJFd1g0?=
 =?utf-8?B?TjB5VEdzUlZ1ZFA2aE9oaHJETXk2eFBVWDhKOC9PTzdSUkVIa0ZHNDI4R1Zx?=
 =?utf-8?B?RzFId2s3RkVoN2tWaldLZ3JTWWw2MmZVOHIyeks1c05jT3hWbVpicnRJQXVt?=
 =?utf-8?B?dzFQQ1o5RlFlWlBQbnpQQTVYOG4vejFoYjhCcjgzYTY4U3F3WUZrT2M2dlJj?=
 =?utf-8?B?ZUxyc0JxbmRia2plb1FPUEE2SU1LbmFvMG14SmVGSlZpbXVBb2x2YnEzN1Mz?=
 =?utf-8?B?Y3VERGwrWmFmSkVva2tMUW5jMFBhWDhBaG51M21Zdlo5amx4N0xsa2FJNnBu?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9c515e-457c-48b9-5cb3-08dd151f1642
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:22:22.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCHjSQc5OSQ5vn2p6OY3YnU/3pOSy9dhBtLuOQ/BEYCxZyMnN74epd95mZA1qJw7sdqLphvg1/b2go4R/wXuRQVlElaL5RHFDMuscpLH9sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6859
X-Proofpoint-ORIG-GUID: zEgaJ7HFCh88WOxA6mjagNROcbNh_xfi
X-Authority-Analysis: v=2.4 cv=cZQormDM c=1 sm=1 tr=0 ts=67518cf4 cx=c_pps a=yS01Tg43EjyficN/GFY56g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=KKAkSRfTAAAA:8 a=JGrr_fRlCiheIX6WwVYA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zEgaJ7HFCh88WOxA6mjagNROcbNh_xfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_08,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Reason: orgsafe


On 05/12/2024 08:16, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 04:05:29PM +0000, Nikolaos Pasaloukos wrote:
>> Add MAINTAINERS entry for Blaize SoC platform with a list of
>> maintainers.
>>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
>>   F:	drivers/clk/clk-bm1880.c
>>   F:	drivers/pinctrl/pinctrl-bm1880.c
>>   
>> +ARM/BLAIZE ARCHITECTURE
>> +M:	James Cowgill <james.cowgill@blaize.com>
>> +M:	Matt Redfearn <matt.redfearn@blaize.com>
>> +M:	Neil Jones <neil.jones@blaize.com>
>> +M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> Just to be clear: this is list of active maintainers, so all above are
> supposed to perform reviews or maintainer duties. This is not
> credits/managers/I-need-to-please-someone list.

Hi Krzysztof,

Yes, I will be an active maintainer of the board upstream.

>
> With the assumption these are active maintainers:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> They should also ack it to confirm they understand the burden.

Acked-by: Matt Redfearn <matt.redfearn@blaize.com>


A question about process: should Niko resend V5 with all of the acks?

Thanks,

Matt


>
> Best regards,
> Krzysztof
>


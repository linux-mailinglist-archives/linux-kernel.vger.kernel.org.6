Return-Path: <linux-kernel+bounces-304587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7365962232
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE24B224AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C915B55D;
	Wed, 28 Aug 2024 08:20:18 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66E156967;
	Wed, 28 Aug 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833217; cv=fail; b=J0nbT6+wd6TG0XZhei23BC2AV4fx8JyX3mvu0AkGIH2+ARoYi8AddKsCFd5idARVHfRwH28ffEfe22sFNGhpHpTP1v20pzHVi/h5zJZw9MKO2PX+OQ0HZ1u5jK2W7fxPRwwSki+UR2Tfq8l0k9iFw34u588BecD6wgC7XetG7Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833217; c=relaxed/simple;
	bh=ab5ahwL8NhC4/ktDa2dA/Znbg04KQYyF7gdOzygD2M0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KYPhDdcaswFfSRThkAVTpOdwMEt7HPmAFmy+2HLSafi8cK/u8qaTU0SMp5MOqS+N5WYOZrOXBoTZ9qXQ1/eezN138iFHs4e3fm5jAXfrTIYAkIwchNjvQ/VwXOxt8bRYBSwqid3g7LmILvV/I9NxC0UFxEQwemdNmKYk135WyvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOYPCSPO80xN9tOgypq3yUeW2/FXwamcYYBRrDwn8iIEAEgGFb1S80t8LFCTdINd6kEsS1mv8FhorANYR5XpxaUHZZtuLuZ+COoDXyH9Umrd9ejCOq8a0VNrWJ//BEVihdBltVT/hOlvugJrtPYFp1Wunl5feXPjnX+avg9AQ208JDoYfeQWVSbEvIw6BAIbPOtKKBkwndtq+y9Hwj0Ypdd3iXEQWyBE4z7WiSKG0oDhB3VPDeO0/msPnIVsXensGFfyFCfa1MqODoCLpbxNC9MB/njm6Y4+meRQhgktd9+L7Ut27tZcAByD7ySR2IjQaH5KRViE7oS+8tIP6VN0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFoMQB1BInVeq/9F9c9L7csWl1IR1FsB6fDQdqkS6t8=;
 b=I9Qs1oH2eBQHdJpI1yn/AxIxYZ/b6kkQh/bBvZjy4Z4Xnn9SFKhei/waTShWHzeDfou1W3oNxJX1gSWGVWRf6MbH2IPSCVd2502iCeFI5xRbYZpqdsN7WtCNkUoppPZOUZ6YySKBZpWlMzcUb1So2ys0bLS92YXT4MSmjdt1WRa1M5yiAO/g/5Jy9JSauF8M1KydTJFEOG9BY7Pg1rUJrUC9PsDuIxLMjGpGGCzXnPWdCbIVgSW6F6LCnYbEUoaDMfF40ZwDCl5AnykEJL4ncQPwX3Wx1YTH7LkmGfLHQTsgHcrr/bLqh7IsvvMmPqMfvdjG/jMFqi7wRdYBIom0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB7772.apcprd03.prod.outlook.com (2603:1096:400:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 08:20:12 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:20:12 +0000
Message-ID: <661258ad-48bc-4463-a151-c6b09de40a2c@wesion.com>
Date: Wed, 28 Aug 2024 16:20:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/2] (no cover subject)
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Muhammed Efe Cetin <efectn@protonmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
 <2106034.K71DO8KEF6@diego>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <2106034.K71DO8KEF6@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0242.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::9) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc2f027-a8d5-4a5e-9c25-08dcc73a3cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVVINWdoU0tMZmxtRlBSZnVxWkRKVnFJYzEwMldaMWU1TE5wN01ZQ2IxU2Ji?=
 =?utf-8?B?dk11UHZwS0c3UDFoYWtFVWR1VDJrTmpmQk5WT05mLzc2ejVYd2FYYnp1SWtu?=
 =?utf-8?B?b3UyRHhZQkFSa3VsbDM2NVRQOXkxYmtaOEg4aUJIYVJyNFZrL1lFM1BWNFRN?=
 =?utf-8?B?Tk8wNzV6cG51ZXFLTGZ5UjZlQmRtUVJ5M0E2S2NHMXFkdW05ZzFmRUlubTQ0?=
 =?utf-8?B?L0RKbHgwcDhOWThpb21QQzZ2MnJ3UnBUMUt0TGdDeVdFTmRqdVlkeU9Ib1Bq?=
 =?utf-8?B?ZS9LM2NyR25zL0lyNTFLMlFwNVhGQ3ppY0ZZcXJKamxEYjAxVlV4QkhneEZa?=
 =?utf-8?B?WlJpaEV4Tmp1RkxpTjZtSEFBR3o0QndNck9mdnZEakVlYnpZQmQwREpVVjAr?=
 =?utf-8?B?V0tSeHBWUjVYMWM4Sm1jZFN2OS84dUJlRitFdU02UE1uZVdKK2x1c0w3ZVA3?=
 =?utf-8?B?T0gxeE83K3A1MDdVRGI1aEFLTWlWSUJaK3ViSjh3Qnp2VGVXUW12V0RveTht?=
 =?utf-8?B?cjRGenRITzk1MkJlaFZXSFIwNFdPYlVOa2tOemo4OVExME9LSGxjbmpBSVBR?=
 =?utf-8?B?ZUtSbksvSFg5bWw0bnZzUDZ0bmg5RW4wbXRGVlpNMFU2ZW1KQURtcHJqU2Nx?=
 =?utf-8?B?djZNQUdYYTM2MVNKd2hXRHZWYkJidlNwaUxsRHRDSkVsUHpTUWxFOFZ2RVRh?=
 =?utf-8?B?NXo0Z3MwN29ha2dLNUN3Q0VVbHkzdmxscWtHS0dINU81VzVVMjBzU25iQkRM?=
 =?utf-8?B?eXZKemdGQ1BVZnVqdjBtcFZuam5PSjFpZFZLK2FnY3VvZjhLSkJCcXBYSFo5?=
 =?utf-8?B?Nnczc1JIMGU4cFRTd3Mva212SkV6T0VOa2RaaFFBZ2xOTm5wUFhQR1N2elB5?=
 =?utf-8?B?bkdmdDd4SitaSExCdGJCb1NhbUhOQjNEMFVXbVN2SDVBeCtPbDROY3owcE8r?=
 =?utf-8?B?cUNyMmZ4SnVPQ2pnM3ByaGdiZ01ieUFwYjMwUlgxKzc2RElXenNKUmhlVXoy?=
 =?utf-8?B?d29zR0xaMUdUZll5bHZyZUJ2VUt4Y0M1N2U0bDVSV2ZkN1dLSUlDM2ZwQ255?=
 =?utf-8?B?WjcxWkZQaDl4UTZhUVlEZEx6d2w4RmoySFJxTFU3bVhSbmpkc3VTWTFpVzJL?=
 =?utf-8?B?MjRyeXZnK29Ca1NxZkhMa3hyRWhNUXVtazh2Z2l6VTBnN2R3YU9TQmpEOUZN?=
 =?utf-8?B?YVJWM3NFNlR5MTdqWU9tUlJKWE5pQmo3Z2JKRnBRRHdBTnR0MEo1eGVJZExE?=
 =?utf-8?B?d2xBc1dkSEZwVDBMRXMwOFo2VWpCN0tySUpZL0lqeDNzOGVFZzh1L29INUcz?=
 =?utf-8?B?YzQ4ZEVCYklXSHlCK3BzSFZ2V0kxVmRSanlvMWQzUkpldmZSSzR3OTJRTWV1?=
 =?utf-8?B?bGZ1amVuOU5OTEpjUUxFUVVjVzdiQjF0ZHZaVjVLZ2srcUtJYXlOa25JdU1N?=
 =?utf-8?B?azNyZTJGWkI0V3d1RG82WDluSG9RckoyL1hMZENLYzBkTWNlaHZmMWNod1NZ?=
 =?utf-8?B?Y2VWeEN0VmVFRzVNZ2F4QjZ2eHRnUXVsWmlPTnZsOG5KajVrK0w1L1dOMWpB?=
 =?utf-8?B?em9aSVB3WTVkRW5pZnVtbzJhWVBYeEVFcFJ6akFjUTJDY0pPbkVOVTRZVXZy?=
 =?utf-8?B?Zmx4S0xuL0tCRHRDemxBWjhxSjUrNzZiMVorVm01MThPNkNhMS82S1BJZVM2?=
 =?utf-8?B?Q1pNd0tXK2NlOXVsT3FlcUVNUWF0cUNOcm9PeVlnaGYwYzQyKy9qSUtqVHA4?=
 =?utf-8?B?VjhXTHc2VW5QNzdGdzlzdVZnWWNYN0dPaDUwWExpSkhNd1ZIUkhud3M1YWdh?=
 =?utf-8?Q?DJtaugSPjixvrScQoVRIL8zM3cAR06Yh6gqjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUZONStzMUx4aUx3R3FHeWIzU3EyUVRSL0duT09QM09CRmFEN0FoSDc0U3h0?=
 =?utf-8?B?MmJSZ1ZEY2kvN2JBZDZzSUJpM0UxTndWMExaUXQ3b0htRnpqZnVQbHlQbWRZ?=
 =?utf-8?B?bTEySG9HL2djT3I5TWIvUTl2QjRTdVpyeVlmZ3FJQ3BZR1lGbVJvQi9qSkJZ?=
 =?utf-8?B?bi9IQW9oVk0yZVFXQkVVS2doMkpIbzBtM1dYU0pxM2tzK2ZEZXpJdnU3VmZ6?=
 =?utf-8?B?YkxxRFZMUW5lTFVBOFhFWjRjVDNiRHlRdWZxNWpNaExOejg1MzVLMTY4MmRZ?=
 =?utf-8?B?MWhYbE1XcVEvT1oxMllaU1Fsdm4yUE5GNTRVd1RwNVlycXpuVUtHOWMxWmpH?=
 =?utf-8?B?anRkTzVXNmlTVE9uWUYzQnI3MURhRzdKTE43TERnZjRDTjdYaFpmenVZYmJw?=
 =?utf-8?B?RC92WStuU2IvOFlDeDZqMlB3SS9qUHUxdkpVeXlYQzBoN0IzcGlaVjdzVmoy?=
 =?utf-8?B?a3BVRmVhZ3N5ZnRFNkRWOHBiV3lKbVZ1RVMrVGlrcTdPbFRSaEI3YnZBeDl1?=
 =?utf-8?B?WlpGREh5bmRqbGNOelZkblAwVTZubFBFbDRneTV2aEQyZUhlV280U3B2MmFq?=
 =?utf-8?B?cFRJOTF0T0crcVIvSWllWEZEbVFzMGRnWVUzZWp1MWMxMzAvbGpNMksrQ0xu?=
 =?utf-8?B?cVRjUHQxMEMzS1lLMTh6a3hWMlowUmVMSFFuZzFSa2ovc3VqTEliNUxQVjhu?=
 =?utf-8?B?R0RHcjlPYlhjYW40VXc0dGxlWDcyckRwZmFFMDBrSnUwcitiN1NYN2dXVTZ4?=
 =?utf-8?B?RUluYkdxVFhFRGx2THVaeHFGMlZ1NCt6eEgvbmdMYm83UnNQK0F5cXpUVUZL?=
 =?utf-8?B?a0Y4Zlc5bEtXam43Z3pzdy9xVEtxMTRWaVFXeUNpekxuYlBTSElONUR4L09n?=
 =?utf-8?B?dGJrOUZuVURxNXdWZnhuUnBJVnRkSEgyTDFkZHNRU1B0VFVvSFpZNUJEQ2JI?=
 =?utf-8?B?NXVHUDZybGJCWW00Q0hKK0hZOEZVSnV5YlRGczJpRVZjN3pCT21KRmNlS0VP?=
 =?utf-8?B?b0tlQVo1aWpldW4rZEloY0J1Tm9lMzR0ZERFQUdKWVZYazE1RTIyRnRWNnBS?=
 =?utf-8?B?KytobVNKUGNzVWlHV01JdEQzdXl4ZzlneXFMbkpzV0M5bGtDdnZnaVJMRjN0?=
 =?utf-8?B?RlcrdUhkVFplWHRJQXhpUTgrMXlLZ3FwU08yTXdjWEVqMXVFaWJVVVNWaDFq?=
 =?utf-8?B?a2RPM1VuQkVWZ3FXVE9VekxZdGFXdXVVTm1qc0RQVm9wa0hxTEFJOE15TGNh?=
 =?utf-8?B?SEk0UktENGc4d0tFTVBGVFlaS3h1VUdUL2lQTmU5TUlYTWhGNU5uT1ZhbHg0?=
 =?utf-8?B?REQ2dVNPeVNMSmQrNGVKYWxENGFYMHA5by9YWmVuL0Q3dFc4UnZLcnFKRVZJ?=
 =?utf-8?B?a1NVYXdueXRjN0tsdGhudGkyRnBWamUra0FFNG50SENXSzVPMFdiQ20zR2Zk?=
 =?utf-8?B?Q05PcEZiMldibUEyaXNWRGRPNStoMUsxbmRBVGlVc2RJQXpOUS9BMUJDcXYz?=
 =?utf-8?B?cFZZR2pvUkdoZkhSRnlXVjFUM3Q3bzRHeXI3MmZwR2V3cGtyTHJkMU1KMkNp?=
 =?utf-8?B?ZXZjUTF6SWRiUGVCTTQvT1BibTJxT2kyZmc2V0JkZDZ2azRvTW9WS1c1MkY4?=
 =?utf-8?B?Uk5uOVNNQmdCS1Fmay9NamdPd1ZHVFlOQllMQWM3WmJYVmx3VmZtS1NQbE9v?=
 =?utf-8?B?aCtnN29iQkkxU1BLRG5OUXpMNWVBRXZvVUVWTGc0WWo2OTlnTjlHUTY5eXJI?=
 =?utf-8?B?dWpxVVRVTjZXZitCcDRPY2xrbUhuWkl4MVMxcTNTV21Hd2FZeWVMMk50cWY1?=
 =?utf-8?B?VTAzb3FSWkxIL2UzYmNGanJSMlhGcHh6a0NtSmZLWVp6dkw1clRhd1VZWEJz?=
 =?utf-8?B?QWhqNGUxcENRY3Q1U3RmWnRiZUNuazBJK1NtN240ZzV3bCt6bnpSaTlKQk9Y?=
 =?utf-8?B?emdrcVFGRVVVZDFoaXVPdWRaTk84dHdJYVFKRVRpdm9OMms4dUtEbmNBbWsr?=
 =?utf-8?B?RkxNNlRJS2N2K1dxYTdjcnBUdTVqbnYyWFNDeTFyVkFuN1lWQ0E3TTVWem02?=
 =?utf-8?B?eFhrNEdsK21BN1UxdW44RTlGbjVTZi9pRlVLTkozVUUrV25zdSs2QXdZQmJK?=
 =?utf-8?Q?V80UhXtWQMfvVuusieUiRVFQt?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc2f027-a8d5-4a5e-9c25-08dcc73a3cb7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:20:12.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLGiXwDoFMuP0q8S370ssXnSLp7St2wUfKl8aaB7c9hy+FvZj8SNzwpAWsWv+CQK+nWteiAx4poFXZqHOsgOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7772



On 2024/8/28 16:18, Heiko Stübner wrote:
> Hi,
> 
> Am Mittwoch, 28. August 2024, 09:58:48 CEST schrieb Jacobe Zang:
>> Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
>> compatible so add it to Apple's devices.
>>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>> Changes in v12:
> 
> I think that did go wrong?
> The earlier version was already a v12?
> 
> Was this sent accidentially?
> 

Yep! Please ignore! It is my first time using b4 to send patch. So mixed 
up the versions.

> 
>>   - Add fallback compatible for Apple's devices
>>
>>   - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/
>>
>> Changes in v11:
>>   - Split DTS and submit separately
>>
>>   - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/
>>
>> Changes in v10:
>>   - Use ret instead unused probe_attach_result in sdio.c
>>
>>   - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/
>>
>> Changes in v9:
>>   - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
>>   - Add if statement for brcmf_of_probe in common.c
>>   - Retain modifications to of.c other than the return values
>>
>>   - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/
>>
>> Changes in v8:
>>   - Add appropriate errno's for return values that will be
>>      send to bus when error occurred.
>>   
>>   - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/
>>
>> Changes in v7:
>>   - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
>>      value, move clock check to the end of brcmf_of_probe
>>   - Add "brcm,bcm4329-fmac" compatible for wifi node
>>
>>   - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/
>>
>> Changes in v6:
>>   - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
>>   - Add return if clk didn't set in DTS
>>
>>   -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/
>>
>> Changes in v5:
>>   - Add more commit message to the clock in bindings
>>   - Use IS_ERR_OR_NULL as a judgment condition of clk
>>
>>   - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/
>>
>> Changes in v4:
>>   - Change clock description in dt-bindings
>>   - Move enable clk from pcie.c to of.c
>>   - Add compatible for wifi node in DTS
>>   - Add random seed flag for firmware download
>>
>>   - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/
>>
>> Changes in v3:
>>   - Dropped redundant parts in dt-bindings.
>>   - Change driver patch title prefix as 'wifi: brcmfmac:'.
>>   - Change DTS Wi-Fi node clock-name as 'lpo'.
>>   
>>   - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/
>>
>> Changes in v2:
>>   - Add SoB tags for original developer.
>>   - Add dt-bindings for pci14e4,449d and clocks.
>>   - Replace dev_info to brcmf_dbg in pcie.c
>>
>>   - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/
>>
>> ---
>> Jacobe Zang (2):
>>        arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
>>        arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible
>>
>>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi             |  2 +-
>>   arch/arm64/boot/dts/apple/t8112-j413.dts              |  2 +-
>>   arch/arm64/boot/dts/apple/t8112-j493.dts              |  2 +-
>>   arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
>>   4 files changed, 19 insertions(+), 3 deletions(-)
>> ---
>> base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
>> change-id: 20240828-dts-1b163375c49c
>>

-- 
Best Regards
Jacobe



Return-Path: <linux-kernel+bounces-335562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374597E775
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6009B2182B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910E19341A;
	Mon, 23 Sep 2024 08:22:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443519340F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079722; cv=fail; b=E/sNQqH8ONffrPVXcqExb2PSO9b+Up+b8nljiNfZQKcmrFEmqC2muD3/vB4y5JwAoRMQUcGQfSebLnHA6bMDTR9yAPqkfcdQVaYKo9nWZ/uAPz1C5lpl+s1rpAks0UaH+bpv/YRkSUbXGVREsRJAb+ZlvCXU/2T6FW1Zpj3bNg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079722; c=relaxed/simple;
	bh=zS20bsXtAhn2glKFrXyTU95xlQ56MPdWOEijxWwyQcY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adygY5UvMQy7is4XilQmZd06lsjJkTMLpq/fVDkhlZqmYhArr18e6iaARJM85usQSRZ1bYdH1VTKE7hWyywMPj7mOhY5WsjTR621UwfZa61D/4sQdyiJEV+KInKdvPI4K4EFZ+kBmITA2yeQC/hQWL8XKQxOJNdISTh1h2T9N3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N5fec6007147;
	Mon, 23 Sep 2024 01:21:20 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41tvkg8b1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 01:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqGOdUlHTtakdvcPkZWAfPQhT96zX6/cnlXsC45WZa2YrXGEHuK5pb5ZDMg2kLzIzTW0/8jeoGPa9BBADxse03kCAPRza7dOkpLhyWBdC9ZngLfu3imUC5uN4SpqS3lYKYA507e1147ZKRmQueiDcwsDt1VXF5gPOtjsRCW7FMzAvX5oc03FbX1t4AUttt+jnbbAH7JX+AQSbEyx8EjdaSeqDJguMX2Z5jd29yDpMI3dkclDeIKIXtHSHhjp6pmrE3Fe6E03eABoM/m0wHUtEW7yO/a6KJyDTvY3GVYKutmSPnmyU0VRP7Om0XvTrrG/7ai/hMvse5WUt2fidBosDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVNPEbmuAdWIYgCIC59qME9DPLIe9/rZS421Lg/23hk=;
 b=j/hE5jwz+WUIivwz2J7s6ZWFv1QGDGGu0ZmJiEYilBepbhDxWWKPneaFqMmV3JoKbc4jW2kS5dBZwa3osJALIx2+qXuaMQv7M9GCKFSVAh9ZCJQ5UVb3+bD7ooGVEffdtVtcoSSC+Qkgx/FpOgG8pNoACwhUj/NfkfAbA7VViw+DGN8VtCx3fdF4Sp1OW++C900SUjJG23cxA/hPtXF9IRAeiYc49APp2usaWv2g013S11DK6a0IQwEqgCrjfF9ybfeYMnLsd6wCbaL5IyBkmBnHXarn+PkGJo9P9LOkhm3IlXR1P3bX+cDMit3NLuVu1b6VAzhRopX2vFN2AUuXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:21:16 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7982.012; Mon, 23 Sep 2024
 08:21:16 +0000
Message-ID: <34533c4a-994a-4d4d-bcaa-b3f517c8695d@windriver.com>
Date: Mon, 23 Sep 2024 16:21:09 +0800
User-Agent: Mozilla Thunderbird
Subject: commit 55516b355b0c cause SMEP/SMAP feature not work
From: guocai he <guocai.he.cn@windriver.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <203df167-267e-4893-807a-42ad3c8934f7@windriver.com>
Content-Language: en-US
In-Reply-To: <203df167-267e-4893-807a-42ad3c8934f7@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 27928e1d-043c-49ac-235f-08dcdba8b186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZrSk9sWDNTZTF4eDU3VE5oM0FFQm03Y3YzVGNwd2tVNUg3UytZS2lhSU5k?=
 =?utf-8?B?K1l3cmJNby94ZkdEVlFwdTU5Vnk3eEJvcjRCSWNDUWNZNm1UYmQ2eEZlM25G?=
 =?utf-8?B?dnBQYW1RNitSc09MMzBVR0M2dGUvTGc5RmlwWGJ1cGVXS2l2Ymo4SmNHN3ds?=
 =?utf-8?B?Ynp0ck44WFNMVC84NWhMMjB3UmtBN3NpNHdpclNVUnJlMDlWbW9hN2Q4bEVq?=
 =?utf-8?B?VHk5YlRyYW9JS1Fhei81SHpWTEhMSjJKd0g3dm80MDdXa1JyNzZBOUpITExt?=
 =?utf-8?B?d0F2VTBWNEoyZEpNQTJQNzZ0VG9CbE55ZHUxRzhLdWNVV3NLa0FwWk5zQURu?=
 =?utf-8?B?ZjQzSE9veGY2SWxIclJGN1k0SnV1Y0tqOHJkbFFhYlhDUXoyMjRqZnNETXoz?=
 =?utf-8?B?RlZ0Vjc5bG5xNEFwUzdkeWNNVWhVdXA2b1pBQmgxZ2xUR2VOVGJzZjA1VTRT?=
 =?utf-8?B?UDBmRHR3U0I5N2U3RXFySno2L1l6NkFYVlgzSWdMdXF4OEZRQVRaMXpsVld1?=
 =?utf-8?B?VTdFUjVlUlZQb1NFZDcxSkZYUmZ1eHlHcUpQOU9YRlZsOUNNREs2bFZ6MlhM?=
 =?utf-8?B?UXd4b0g2Q1hscmhaMGlzUGJEUGlSM3lEYWo5WGVTTUV0VkJXc1dHMSs4WHpq?=
 =?utf-8?B?N09pa2pkMGErSXNRbStScWRtM3F2WWFGTHU1eHNmK1J0WG5QV0lNYTZnbEZO?=
 =?utf-8?B?dE9zeWJsRWVETWMyUE5xMlhNM1djaDZSRzlzTTc4S2ZKYzJRZ204OEE5Y05V?=
 =?utf-8?B?cjl5U25WMEVWTFRybzE2UUMvNWVZN3FUbXU2WVdZZm81WlFGZ3VsRU12RWRN?=
 =?utf-8?B?RnZaaXhoWEd6NTNxYVU1eWQvaTdCU08zL29hYSs2RlVoc2h4NVk3VEY2dDFk?=
 =?utf-8?B?TVptTCtMMHlQZjBZLzVrOGRtRmZUZDE0cjB1SDBzVzlSOHpDVnBBVWdHbi8r?=
 =?utf-8?B?UUdWc21iK21DY0dnWUR2Q3BMbnhmUXA4VEdxc2tNRktZekJ1TUxpZ1RNY2Q1?=
 =?utf-8?B?c2d1bTFDSk44T1lnSVlkL2ZFMSthMVRVK1NUaloyZU10UCtSSk9UbE16NDhY?=
 =?utf-8?B?d1dHMTlTckU3Zy9GYTNKMmVtaWgra3RwNmRFZzJxMWlHSWZwcitCTDlEVnR6?=
 =?utf-8?B?K3U2cjRHSEZzTnBJcVhOMWhwVTNUOGE2dnNPZnhldlNuRXM2YkRRdHpLak1V?=
 =?utf-8?B?bHlXMWtxTFpzb0IvYnE3bkRYNitlaGtJN2NtbDBrREljUTVuZUlIMmlTMzJW?=
 =?utf-8?B?RnNXMHNLcTVsYTllTi96ZkFVd2lXRjkvaytpTDJqNjR3NENmOUZ3ejNZR3hO?=
 =?utf-8?B?N25FWVYvYWt6cy9jOTlNbVdrY2VvV3BCcmJZU3A0cnFScXkxb1NRY3dSaEJv?=
 =?utf-8?B?TnFnV292bE1PMFpNdmdqY1NuUHozYm9qTkEvd1NVdjZNZmIxMTA1cTZkYlh6?=
 =?utf-8?B?UytXTFhmOGUrdVJwaVFsSy8yZVZxYnBoeWh5OUtGbldhQWRISkpiZERyRnZm?=
 =?utf-8?B?bGIremxNNFMzZ0JTaUdabStkcFM3L2dkWFdYNWxkWlpsMVE3ZXZ4eDBIY2Y4?=
 =?utf-8?B?RVNwcXQ4MHR6SlhVZjFoVGxnV0tCS3dGSU83Zmx1N3YzaEtjK3RSNXBrdGFq?=
 =?utf-8?B?Y2x4MlQ5Si8xUmJEOWhrS1UzWjc3OWtrckZFZHc1d1VjdlQ3ZUp4TVp6SWxL?=
 =?utf-8?B?WXFBUGlkMjVBNG12eTdhUVlZaUVKMFM0N2dnUUNhZE1GZWlnYzhoTG1SUmJP?=
 =?utf-8?B?MWZTVGw1eGRRRXVnbTl2bXdzYVZudFd4MVhQR1NvRk9hdzZZbVd2bkZGYzBw?=
 =?utf-8?B?ZmtGU1l3M0VCUDBTVFo3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUU1UEl4L0ZLQllLVFVoOTU5ckZzQitjbWNQMTA1VG5sUEphMmJCdmpWb1dY?=
 =?utf-8?B?NU9LbndtSXJxbTJnL3NsRjZKOGxVdXp4eTBuSGRFcWJSbVplTlRtdU5FMDZX?=
 =?utf-8?B?VnpNMmZBbWhuamJKdm9QaittYzJxZEtxL0ZWZ3gxa2FqK29aTmMwVVpPSEQz?=
 =?utf-8?B?eW5KU2hXbnlYZHZPRldiM3A4WDhmdWVSYUpYQi9xTEhZQlZMdWdOMDVGNnE5?=
 =?utf-8?B?eDdqZ0JHbkpOa0hLY013NGZlek9RYmQwYnQ4K0ZaMHYzNUt4Z20vYWJwa1V4?=
 =?utf-8?B?ZzdJaStUbzduOUx1OGQ5dWlmZVp6MmdaWFlERExGbEk2K2FodUFyeWNzUGgv?=
 =?utf-8?B?WFJZTkZvWlFob202NU9wanJyYUNNVmptQUd4UVpCakl6cnFDdjdsRDJsajVo?=
 =?utf-8?B?QUhFV3dkcHpWdDFaV0t5d2hJNVl3VEc0czBad1ZtWVBSVTh2dll1UjRnaXlk?=
 =?utf-8?B?SSthWEdHTGFPeXpLbTRuVWE2eHNvMXg2ZnRWWnpxcXBPUUxZamZRVmYrWnNo?=
 =?utf-8?B?NTlQNXhHbGFSdUgyUFFOTEFKSDZqOURGOSt6RDVuNlgvcHRRVHBIeXUxZG5F?=
 =?utf-8?B?a3dCc1lhZkJwNkR3aFdrUCt6QTRWSHFqOGtsU3hUT2dKaS9lNUNqdndUS1N5?=
 =?utf-8?B?UmhVdHlwOGdvSGwyS0lDQURWcVUzUStDeXNVRGsyaTNPclJsZloya3lrY01Z?=
 =?utf-8?B?RkhNR1ZNQXREd0NQOHdmaDlZNE5TUzdMdTdEZC9uUFYrc3JhL1dTVVgyeHJk?=
 =?utf-8?B?M0Rlc0d2TWdXd2lNRERsQWFHL1kySEFhUkZPeVJmWjhGUmt0VHRxdDl4K3JJ?=
 =?utf-8?B?U0pFc2lzRkN4MHNJME1GOEEzQkkyVjltNXdHa0t4RjRlU1lZcE96WitLTlMz?=
 =?utf-8?B?L1I3TDI1SXExVU1oQmxUVzNIZ0Zxam1zZ1Y4NUVFLzZWa2JmbXJNbG9CMlUr?=
 =?utf-8?B?TTJkcDJ4cWtpa0pZVjQ5N2hIbU1ZMDhUMzdyQkNQSkxwU0JMNHBGYVdmSjRh?=
 =?utf-8?B?YkRkTGNRdUU1dE9xRFVUbWFWR3loR2FMUHVNUHJqVTFsOWU5TTh1UWZQajBt?=
 =?utf-8?B?aHpiSmtSRXdaTGFNRHZkckd4T1ZMNEVHSTVFS0haTTZyQURWUlNUWU4yTDdp?=
 =?utf-8?B?blJXUVVYd1F1d2t6UmlMQnQ0bU1HTStVSHBKTHdlN3laeVl4dGNkN3o5dmcw?=
 =?utf-8?B?YTZRT1NjWjlpbE5CWUF6bVBBb2dxSXhUeHpwcUhQTWNPMUdqZDlmV3RMdC8r?=
 =?utf-8?B?UDN2aWZiTWpycjlrTm9INHhCZDJxTFpSQkRZTFJLN0Y4WmlWWFg0YThSdmR3?=
 =?utf-8?B?TGFhRWpjRzZJVWhWczhJMXdKT3gwVGtlQjZ5VDRKdmwxOFFvclZocldPVVg2?=
 =?utf-8?B?SE5Sa3c3V1lrNGxZVitweU0yRUpZVy9XZk1JcmMvUjhEbGdQRDV5WktKUWJV?=
 =?utf-8?B?Wjg2RWtTNVJBZHNaR2pzTjg2SDlqMVkzdkRrbTIzNktIUmNKelErTDBMTjlT?=
 =?utf-8?B?YWxpSFZIbnY1SUYrQ1ZicndmNThaUkJFMWt3bzZiSytXSS9uaDZEYU9ta3dO?=
 =?utf-8?B?VWFsOEpXSGlCK09FMUFObmZGbnk4VnlXSEZrcjlkLzgweUlqSmV4VlJRS2ll?=
 =?utf-8?B?b0lITTlyaVFqVUFmNFVTREhtVW80OU44cnRUSFlqbi9pZE8vK0IySWdHUDJ0?=
 =?utf-8?B?aG9SclZHQXJiakRaaXU1M0R2cnlXd0FBMElMeFJ0dUsrUEMweElqWmM1Uk9R?=
 =?utf-8?B?L1pyNFZVRFZVTjJJckdvcjhMZ2owM2JmcTRMK2ZvYk1VZlQxYi9QUVkzaTh1?=
 =?utf-8?B?LzdUU0JkZ2IyYXlPVVVseHk5cW81eEtVS0J6bElxUTBBZlNRcHRXcU1jMXo2?=
 =?utf-8?B?TVVyT3UyQW9idDh0VlZXbHd2UTJxZ0Y2QnV5dk50bG4zQkp2d0dsSXdPQklu?=
 =?utf-8?B?a0NHREorY3hiL3RFVE41RkxReVVaM0o1TTcyWE9QQVg5S0FGa1pjVHpNSHRh?=
 =?utf-8?B?VlJTczdCaDZ6Zm5XT1lOc2d4a1REUE1NWGkyS2FzRjZETnl1WlhFZTRFZUYv?=
 =?utf-8?B?ejNpbFAvcHZMRHVISnJJTnVZQ0o2Q1hOTTFRUlFIVUlYaWNTZFFLRTk3ME13?=
 =?utf-8?B?TjZrd2JpZUMrM0dIRURYdlMwQjkya1BZQXp5Y1IzR3dSelVxSVptdnAyZVBW?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27928e1d-043c-49ac-235f-08dcdba8b186
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:21:16.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwNUwY4SlWxfwyVKjVUj28TmTexNCUSw6FAujT4tKx6C6qKCsOkkqrnPL2Ajr3CYYInH+KBhsDyuMaxIVTW9bdgSvUJgNxoiE0+HJ+4hpks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-Authority-Analysis: v=2.4 cv=UqoxNPwB c=1 sm=1 tr=0 ts=66f12500 cx=c_pps a=7Qu+2NBwJcyibZ5HEcOKcA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=wiGDQG9slnDXcQIb25EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oY4mJ3IrQBapJKgABum-L7NtsHU3qPXr
X-Proofpoint-ORIG-GUID: oY4mJ3IrQBapJKgABum-L7NtsHU3qPXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=790 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409230060

Andy, Thomas and all:

> branch: v5.15/standard/preempt-rt/x86
>
> commit: 55516b355b0c x86/syscall: Don't force use of indirect calls 
> for system calls
>
> I found this commit cause the intel CPU feature of SMEP/SMAP does not 
> work.
>
SMEP/SMAP is to "trick" the kernel into using instructions or data from 
a user-space program and get call trace
>
>
> testing:
>
> 1 enable SMEP/SMAP
>
> 2 in user-space, the test case source code:
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <errno.h>
>
> #define BUF_SIZE 128
>
> int main(int argc, char **argv)
> {
>     char *map;
>
>     map = mmap(NULL , 1024, PROT_READ|PROT_WRITE|PROT_EXEC, 
> MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>     if (map == MAP_FAILED) {
>         printf("Failed to mmap: %s\n", strerror(errno));
>         return -1;
>     }
>
>     memset(map, 0, sizeof(BUF_SIZE));
>
>     mlockall(MCL_CURRENT);
>
>     syscall(247, map);
>
>     return 0;
> }
>

> 3 after the test case  executed, expect to get the call trace. but 
> this commit cause the test case can not find the call trace.
>
>
> do you have chance to look at this issue?
>
>
> Thanks
>
> Guocai
>


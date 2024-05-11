Return-Path: <linux-kernel+bounces-176571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4D8C31C7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AE828200E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F215380F;
	Sat, 11 May 2024 14:15:17 +0000 (UTC)
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2138.outbound.protection.outlook.com [40.107.122.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1517C67
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436916; cv=fail; b=rsrs0iYkRDPCvYymOycnDAqjYQaFzHJtbgL7B5LZNpHKDgGoQNrgCxKtZveomX+FRiioMcgKlTWfe2w60zFVhpoIyBfpd7yALOeEn4MznhNhKZXr+pw8kH1JMYyOO+Bs1G0FP8SLiPlXc62B1mKdwnDiVPelUJXp/eW9Z/ItdiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436916; c=relaxed/simple;
	bh=YQeH3cgeB6yOKw6qvdwuwswqFUlzACoHwDo+BtoFRuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVV+6BSBZXDArT7e7meZR/7xFUy5E9DII4hfrYrzaxLsK1J1ToiPqwOm7jbBW9JKH7i/1GjvnMfgq3joWYf0haHkX3ITXEvNX9s1QmhKflIvxm6LKcxY+5D/IgeC1uehJ8YQOwn3up9C/8+YYkPp/rWe9NIWYNmLulVYtyO6YQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=40.107.122.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCongycJPG8kFJNLf1AAAW1xeqd2r9MfFuVxqUbgO/ab7N6LGSEweRKPXegLD7OmytD8NuLUJVhN4KNKFnLjD+JxCJUnGe+nqKhaQVHCAhTbLNyXmf3e/nbkpsbo9yQz4rw7YC/3PxrJEXZHGVWud+/cxg494fKJKD79wCGLIF/hm6OEUpp3Kcl6zTeMjTE8429fRDPoD4lS+euuRBjydSV+uFkcZ5FzQNXUscRzyQfsFyXCTEaM8CzZnSUhTDZxp3keFn2eiA/us2zRqSUQsS/oHN1oyH84perulXcA4C9gnUB4YsYW/mwGQsAqrTBPccghOg6dUh7pridz6599Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhNJVZz4HPpqHFmGtUsuJBpLaAd58AZ+RsXtzFiQRMU=;
 b=J9CBJYv0rhfcmxFPskhK4/FZqFchdEqYWyftUxWitgWVwHA28vKFuKdn/kODfZhT9rYteDgY5wcRcoy9m/v/cvdi9fG2es1Ao5VnLRPAlYHv9T2Up2/pVLDl5rHAUwKBPfsbM5WsiHMzfuJaX8h+u36nG1CMzu0RSS12k3E85QS3e31UdWXXCRgv2GwNpVe/w1N17bmyGtZ/z8/c4fD9FrobnIixqtEZdTygAklK4AFctY77GurMpSW+QjyKMDhI3K3U5RYFsH416MSTCaVA51E7LmZVhWBQm1XeEY9Ik3XFAw9BBtHBP8Q7rTunYfjjQJfFEvK6vN0FOHZXOpogOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB5771.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 14:15:11 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%4]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 14:15:11 +0000
Date: Sat, 11 May 2024 15:15:11 +0100
From: Aaron Tomlin <atomlin@atomlin.com>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao22@gmail.com>, neelx@redhat.com
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Message-ID: <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423182104.1812150-1-haowenchao2@huawei.com>
X-ClientProxiedBy: LO2P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 396a863c-6570-4f86-8388-08dc71c4c55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2V0TjlVa3RqR2h5TkNxNW1iZjF6R2gwbmtqSzN4ckNOekcwcXJHWFJOTCtR?=
 =?utf-8?B?ZVdjS0MxcGJFMlUyNkVpR0ZiM1VmQXkvNW52K21FR3cwdU01S2JRYktCcG5X?=
 =?utf-8?B?QkEvZnpNaGhYMDREek5GVWVvZy9QZEkxSVhZd3JLOVl3UmE2NElvbHBDQi9q?=
 =?utf-8?B?R05TaWQxQSs5UVhVWmpnano3Y1hDYUw5TjVNdW54UStoSGZxTHdSL2Izc1l1?=
 =?utf-8?B?S0FkSU80bkRrVFFpUU5PMlJxYmdKTW5hTSt6bFVKRVlZYXVUSklSSGJ5RTZI?=
 =?utf-8?B?LzQ2ajVUSCtrY1pGanNGSVVYS0IwQjdRWEJFLzBmQ3NsNWdROUNkOEx4NVQ2?=
 =?utf-8?B?d0dzZFNsZHdSazdhZStLNy95U2xkbm5sRENCV1pxcEdTTnF0ZEdSVjZ0WDJU?=
 =?utf-8?B?bCtwazlybmZrVkhyRXJoYnpCbW44ejA0eXVZYUtESFBLMVM5WXRiVDdMSFlJ?=
 =?utf-8?B?TXcyakppNTQxc2RQeVozbUVIL1hyY0hUSzQvTFZVL1IzVVJmd2gzOU9sUWh5?=
 =?utf-8?B?aWVVaG1yMGJVNER1SVZjWU1UVENrMGF1T1ZsbElZbFlWc2lsWTl6QmJwM2tR?=
 =?utf-8?B?WDJxeTdVektqdkQ0OFRyVjFxVnV5YUlZaWIrVWRsOXRESnFMVjlpMzNYRDNy?=
 =?utf-8?B?UVYrenFER1ZpRDlZd29GZlNnZUg0Z1M2ZGE3aFhYejlQRHNuOWVaNSsyS3Mx?=
 =?utf-8?B?QUFiOUFXNngyTXViUTVEWWRSNFJRdjBKWGxQYWswaHUxQjZaUzBaaWwwOUds?=
 =?utf-8?B?WlFXYlAyWHJIaGtGcTM0YUFvaXZDcmxwV3hjbkc4aTVadk0xeUg3eVU2dzZU?=
 =?utf-8?B?UyszZEJNMFh4ZnF4VDJrcDBuNUxhRDJlZDZEZDZibCtlaVpHejdyemZOVVRm?=
 =?utf-8?B?ZEZIeWxNSXQ2dTNhdDNpenFtbG1NSUljQnF5dWw0c0I0NktmbFRRcTh6ZDdU?=
 =?utf-8?B?Zm52c0V4TlZnOEpUek5tMzBUK1F3ckNNQkc4OXlvQmJqR0hXTjgvdHpRZERW?=
 =?utf-8?B?emsyUk04Y3dueitLRHUxL3RTZWV4WGdWODUwd29jUXk0SHdrY0lpbkh0S0ky?=
 =?utf-8?B?c3NPbTdQaUhqc2I1SWlZeUQrRDNwMlRUN3h5aEsyMGdrQmpHYzZMWnZWUHhI?=
 =?utf-8?B?ckFSSTRyeU9MRm12eERRUld1WHY5eWFwWVpkeVMyUHU0N2VzU2FocTBSSkRM?=
 =?utf-8?B?Mnd0REZseW55TVhmZEJuYkFwZ0padXYvR1FnZlVKSE5JTEFYZk5kcGZSRFZy?=
 =?utf-8?B?eXI4MUFyWFZmT3pBdnlOQWZ6a05IUGhtQXJHQWZNS21RNDA2U1F4OVkyV25k?=
 =?utf-8?B?ZVNTb3hjVHRQeHBWZHl0U0kwNlZLZFJMc1lSVjVTS1MrdjFwSzZXeEQxeldQ?=
 =?utf-8?B?dlU2Wmc0WTF3dDBKY0lpV3c2N0d6ZWdVSE5yMFBzL004UThESEFXWGJ6NFQ5?=
 =?utf-8?B?MTh5MFM3c09qbjc1VjVRNXFUYThvZmdIK3NYUmdsbDM5VmVrdDBkTjFyZjV6?=
 =?utf-8?B?cXdlL3JOa3owYnlwQmZuSGZ4ck1rN3lnS3FWNlViWWhVajdLS25lV1VyeHgv?=
 =?utf-8?B?WkJ2QWU5ZE9JbHFPMitqRFhXMkg4ZW5CRkF6TXRKTXgvalBkNkc5RkgwQ3o2?=
 =?utf-8?B?UW1KUDJiMFRDYXN0cTNFOEE1TC9HTmZ1ckIxY2VrWDBhei9UQ1VXd2ZtL2tX?=
 =?utf-8?B?eFpscnlRTkFVbjVCTUJoM1JIeXc3Y09HVnJ3a2c2TG5rNW5vWTFBSEp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDJlaDVMVW9JWWlFK3pQVUtqM3V4T3VNT3M3UEZ1VlpncEIxVzRiMFp6OUhO?=
 =?utf-8?B?djVabVRJTWVxSjhjbE1veU9UQXJNbEk5UDdiTDlhTjVFbk9SVnhSdEI3QnB3?=
 =?utf-8?B?QWFKWGxWbmorWitydHhSR2NUZi9PQUZGQ3FrdVdGMmpseml4NllPZjZxWXFq?=
 =?utf-8?B?M25pYXlhT3hLZUlaSGJMRkltTXdlaHlJRFNFVnExY3VEL3k3bGRRYzdyQlZW?=
 =?utf-8?B?aWE2M2MweEU5b0hrcmJRNkxHK0xqc0JTOXJPZ0lvY015bHBzMTZaLzFnK0M1?=
 =?utf-8?B?L25sZnZMZDd6VnFOL3VNWmpMOHhMOVJLaDRlNWw5NWM0bXo1ZnZCbXhmWHR3?=
 =?utf-8?B?NG9iOTloQ3dobkNZSCtTcmRmUFpFTnkrYUdpL3E5QnJRVlpITWpIVFBua1pC?=
 =?utf-8?B?cTI4ZVRvcmZTbk5KR21EYTlmNzVRMEYyUnhadlJOVFoxeUkwUVRHS1BPbEtR?=
 =?utf-8?B?enVDWVRKM3dBazBBTW43OVBoUjgvUURkeDRjbFd1ZkxETmZWUlJZbDJlY2FO?=
 =?utf-8?B?S05DcktpYjZNR3hiTWErL1VvNUt6WEJTNUR1SG9icFFrTDlFbGtKYW56K0Za?=
 =?utf-8?B?SGdZUVJFakdnY2UvNUpjN2xTOERFVm5iMUI2a0ZMSVFuczk0LzNFeU1QWnky?=
 =?utf-8?B?Y0Ewc0NlQU80clZzbmJwUmJMZ3RiYm00SDl6QlArZDVuRlcwWXZhSVVqazNk?=
 =?utf-8?B?NkNCQnd3SHIvY0VDdEQvdTBxUVFEYzRab1R0OHNxY0xaYWU5aUtCa1BZcjVl?=
 =?utf-8?B?d1VHdCtjc0lVVm9oV01xbjd2L0x2dkRFSjlmVFo5b0JnOS8ySXo4NnpKSDNv?=
 =?utf-8?B?WDdzWldSTXAvaDhoUWtMYVBZM1FzSUlCZkp2NkJtWWRnbjFXaHRab29KRVVF?=
 =?utf-8?B?WWpOT2RGbkZTRjJzWFJ6L3ZZYmRnOEw1SEs3cHBTV3VtcFlWMnYwMGhldHJh?=
 =?utf-8?B?V09lZTlvc1Byays1bXVjcTVTMzN4Q1c5RDZEL3Z0Y3hrc2xqZzBtTjBOV0lY?=
 =?utf-8?B?TE9aMThvcEpkdmlpeUZ5azlVN21aN1dLTU4zOHU0N3VpdnRkc21peklqWHI3?=
 =?utf-8?B?VFVOa1JsSHhINUNoVlFHS2VHMzBvdXNTamJWd2dCTXB4VWI3aWtzL0xyUVVi?=
 =?utf-8?B?bjdJbk1SdlNHVlNoSkYxUytwN1BYMWg0R0t5SFpsOXExdlRsR09oZkRHSGNG?=
 =?utf-8?B?c3JYRzVuTG1HSlVlVFJ2RnhRendNR1RtU2hWclN3Q0E3UUQyc0R4dGFxQldK?=
 =?utf-8?B?WnBiNGF5UkVQM2ZWUlNRS2YyVHd2Z29OY3M4b0p0U1NFSnFZem0wbWI5aFp6?=
 =?utf-8?B?UHRjQ280eWV2bVdvMnRQamJmSHhBckhZbDRRdVIvUnM1Kzg2OFZEVm9yWGxC?=
 =?utf-8?B?VWRXVTRkbFBnRkczeHlwcS9RMTdlQXdRa3NBVFpXK21EczFQTXh5L21kekdB?=
 =?utf-8?B?b1J3KzNpVTVlSVF3ZGlxQXZpM3pWbVNPT1ZqZHNqSFk5WmtWczUzN0k3WWRU?=
 =?utf-8?B?VlAvTW9tdUxaMUhOMnJFUzk1OUh1S0Zza1NWUlBHcE8za2QrZHhEOVBDbE9z?=
 =?utf-8?B?QlJEb2xLRW02K2J1RWhwK2ZLU0g5VlNxQXVpUzc5Nm9NNXhFWDJ5eHFoMzJB?=
 =?utf-8?B?QXVCb0NXOHhTRFBOazBoTnE1TGt6eUNsNnd4Y2hmWU9UZEVRRXpydUJQV3lL?=
 =?utf-8?B?Z2VjdjFxdmppVHR1bzJPWEpiTnJFb2hZY2h2ekRBVnIyMVJzVGNoSllRS0tL?=
 =?utf-8?B?S25FcUhUMlFvcTRZT20zVjJOSzdDWGh2YTJKcmVlNXZyb2hXd3NZMHl4dmdV?=
 =?utf-8?B?emRMYXBDdHdrRVpUNy9xYzdMSjNmMFNtc2psNndwU1E5TlJDK0pkNFl2SW5D?=
 =?utf-8?B?Nkw4Y0JLUU1uZ3l0MEtOdVlmcG5iejNqNE4yZGlrelpHZFEwTUM5VVAwL3ph?=
 =?utf-8?B?dEZVN3ZrNi9wTlYvOWJGMlQxMnExVXZHWUpJaTdLZk5oWFU2U0VvZ29kNVE0?=
 =?utf-8?B?MEhPKysxMDh1WlA0NzNmQ2U1emovQ1VsNk96aXlaN2szazF1aWt0clY0QlhH?=
 =?utf-8?B?enlVcGJaY3JVMVc1ZzdoQWJSL3JnL1VpT1owWWM2ZHpKTWsvS09wTUJDRFJR?=
 =?utf-8?Q?NbNlv4Pu7xbYfS8ROiW0NcRVb?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396a863c-6570-4f86-8388-08dc71c4c55c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 14:15:11.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5BCAF4H//3bTpbViZBcXT3ImJPBtUg8jymSHE6WlsjnUMhb13Hgn4rO9pC583UwRfLxniK6uu+EN2EdxxHVcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5771

On Wed, Apr 24, 2024 at 02:21:04AM GMT, Wenchao Hao wrote:
> Task comm of task is limitted to 16, prefix "kworker/R-" is added for
> rescuer worker's task, which cause most task name is truncated as
> following:
> 
> root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
> root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
> root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
> root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
> root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
> root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
> root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
> root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> 
> I want to fix this issue by split rescuer name to 2 part like other
> kworker, the normal part is "kworker/R" which is set to task_struct's comm,
> another part is wq->name which is added to kworker's desc. These 2 parts
> would be merged in wq_worker_comm().
> 
> Fixes: b6a46f7263bd ("workqueue: Rename rescuer kworker")
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  kernel/workqueue.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0066c8f6c154..0ce9e8597a4d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5430,7 +5430,7 @@ static int init_rescuer(struct workqueue_struct *wq)
>  	}
>  
>  	rescuer->rescue_wq = wq;
> -	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
> +	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
>  	if (IS_ERR(rescuer->task)) {
>  		ret = PTR_ERR(rescuer->task);
>  		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
> @@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>  		return ret;
>  	}
>  
> +	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
> +
>  	wq->rescuer = rescuer;
>  	if (wq->flags & WQ_UNBOUND)
>  		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
> @@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
>  						  worker->desc);
>  			}
>  			raw_spin_unlock_irq(&pool->lock);
> +		} else if (worker->desc[0] != '\0') {
> +			scnprintf(buf + off, size - off, "-%s", worker->desc);
>  		}
>  	}
>  
> -- 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin


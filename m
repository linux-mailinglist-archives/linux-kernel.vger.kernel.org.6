Return-Path: <linux-kernel+bounces-204050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736178FE35F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC941F21BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC32178CC9;
	Thu,  6 Jun 2024 09:48:44 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D717920A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667323; cv=fail; b=l+jcFN46xQDodyI1n4MamofuMMdK3Gh9W6YJ5zqVlqvEy21nqutSNE4R/03eQbLhd0NAaTfxCvnkubgsHsuqQx9NolZNVloD8WSR2z1qFtZsYtMzhS5eWCEaKz16OP4TkxRUSvXeKssC7HeBL3g/o7m+XseoBnJb0/rQExmHZ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667323; c=relaxed/simple;
	bh=rxaxnq+a/diUIw2eMxMUSJWVlyBSHzDRjv7iU8/Kiww=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IX665oISxHEaJ4gh6P1l25DO6Dr9qxtC5m9h0Jq9+wr9HuUFYVcXmqJDykBNeKZc6+QcsMRyQbvKNakCGDPI7zRkJqM/xFbQ+gzH8/qWCQmowQ8Id6ZhCwIECj1u9pUyjnI+ZKp/IdhrJg3ypBUquhOAppts/emd4DBgjieimNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4561GOFI010211;
	Thu, 6 Jun 2024 02:48:34 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yg35f4u29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 02:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbBpl3FiG3d7ylg6KxQx8vjFMHXpOIVTtiUGfLQ9GMzETonY35FYIBMLR56Nrae03zlQbEnA8PEugdtKhqjaq3YwNOPb2hDDdigYEbwDSNM9oQJCcgSxATmbmB/Xb6f9HuMNaBKJYsOKzcn9qHdf4FcsuQHe84+1bsSAi0NABp+A5oQdP3Yzy4XSKnHMZi6VsTIAXhX5Zg85FDuRtWC505O8SoZrnY4JdNIDICXFkPmsXalOhRAw5/G9mhCOrYav7l/+GFXSd2tek0zQE/XhbdEkh88nxtzChqHjQQetpnAp8lQDmvFhPik/35YFst8A94gLFfIN7xaicMjJGj2lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKD/ZxctYzBCu1c0QYsDEueH/e35scdblb+UFnsViX4=;
 b=EXymSYfLB33kIoZh19MSzAsllaQ7gfLFqzjnZJgfSgpWuRqrOAp6+UCVqO1KJ8Q36fukXy3jqR0LA1v7WZPrAxqe4ZYdPKBjhF3Jnb5S7swKPI6qF7xW/HAOWVHK3/yrtlcPcTkTpIQQXl6nvqthWptRZBOa1y5N6nrIm+2BrF4mw+NLgqJhmnK5DaFBJQtN1uBOjlUVhclEvJX/jocfGVVqFjnUC1vnmlDbQYkFDCJveUxU76yovX5Z86nOu49JO8jkDLyu7yq4IIEMPj7Lok2AyVXaQz//08XUXenbz0f+rMMEnaxxYhTE41XkFN9h5ao5xzMgSF+K3PTEmhkFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 09:48:31 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:48:31 +0000
Message-ID: <f418409a-6a7c-4d28-922d-089486f6fc70@windriver.com>
Date: Thu, 6 Jun 2024 17:47:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpet: Support 32-bit userspace
To: Arnd Bergmann <arnd@arndb.de>, Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20240606061342.2142527-1-zhe.he@windriver.com>
 <acfe6adb-2070-445c-aecc-ec0972355d8a@app.fastmail.com>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <acfe6adb-2070-445c-aecc-ec0972355d8a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 421aba2a-da57-4907-c9c9-08dc860dd323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b1pkcWxSb1NENUhNTk1UN2lEMDVicHlVOHVLUGNGSy82SmZaNXpqYUxqSjdI?=
 =?utf-8?B?endxUUtkeFk0WE5pZmJIVWxvUEl2L054eFdpMUZLMlZJZis4VzB1VGYvSEJ4?=
 =?utf-8?B?eHFrZXhDdEkvZFA3WFBmVnROdnFPQlJYQUp4ME50V2ZEbzdIdW90eWFaNjAv?=
 =?utf-8?B?YjRHbzNuWTZ0b0MrRFhOV0M2Y1orZlR6K3kzeFNDeHJQaThxRHo0Q3VCYmNm?=
 =?utf-8?B?T09CNmlSTUtvQ3ArY3hmV21xQTZCbzFyTHZORWZYTmcyd3pzQ1ZreG1leURv?=
 =?utf-8?B?U3Q4dVc2VWpRSXFLVFRveXdsTVFXR1haNVArZHNsSzBkTXZsS3VlRHZYRG94?=
 =?utf-8?B?dWk1amg2VFV1clhnSC9OemZxNnA0aFE3aTAxeVpsUklUSnBXei9iTkc1ZDU1?=
 =?utf-8?B?UlRkZ1E2ZlBWKzUzMGJvbzN5M0wyMWhzbVlEOEhKZ0ZLaVVCOWl5TjRlb2l4?=
 =?utf-8?B?NlF0bzhPekpiTDVzczJrVGtkYUpzM3FyS3gxcFhQSGpjc0ZoNWNsZjhRWUkr?=
 =?utf-8?B?ejRSUkNRZ1F3Vk8xanR6aU5yR2ZnR0JncWJMUHZxREdrdVcyanVJN3dQNk04?=
 =?utf-8?B?azBGcVNOeVpha0pyQWhCTUx1Z1BPQkphUEh6UmNmaVdkeXpQZS9TNXFkMU0v?=
 =?utf-8?B?b285N0JaY3BKUHlFQU1iQm1oMGxOdEc0N0pvL1RBRmJKdnR0aTYyNTlrUEo1?=
 =?utf-8?B?M3crNVVOTkhtTG5aODUvV3lDZkhDQndPaStOaEF2QmFucDNDN25YOXBacGhS?=
 =?utf-8?B?L2xGLzkrdEI0UzBURzk5YTMzdW5SV2pzUTREZGxoTnBxT3VqeFMvWUwvdGxT?=
 =?utf-8?B?b3g4dnlWUHdyWmozTUJORitWTzI2TW51Ty9vQWpNVlVPWUpWTzRyaURPbW9Y?=
 =?utf-8?B?VDc4OVVscmowOVdHTGtoSE5nZlgvdERJZWdWUzNxU24rNnp5MWFSZi9UMHZJ?=
 =?utf-8?B?c0VZQXAwMG91aHNpTCtDN0J6MGZVcjFkaUh3Y0ZDdFE1T1ZIZlZyYXpxbjh5?=
 =?utf-8?B?aGNnV21iSWhoS0ZXY0JFRVJuSkFrVjZjYytPaGIxOFUwdVBFLzBqVkZUS3hR?=
 =?utf-8?B?UXNYUERJV3ZtQzQyZ0c2VmxZQTU1NEZPWEU4ckwvTEpuZkdLSWhxRUxlM2tu?=
 =?utf-8?B?azJ2ZXV4VVhqY1NaZ0FKeTlaYmlncUM5KzdsS2ZBVm9jSXhNOGZVUFJIbmhL?=
 =?utf-8?B?ak9rTmt0b0d0RFc5Vk5uUzJJblh2VFlVblFJYXVOYytUTDRNbU1QNjdNcjUy?=
 =?utf-8?B?ckhKSk1VQjBad1ZzUlBMNGwyeDJ3SnRaQ1BCQjlQd1hDTXlzYWVUcHZHY2Jq?=
 =?utf-8?B?Y3ZDM0VPRU10dUJuLyttMTQvcGFZU3hUYitGR1l2Q1RLdXNaSDBMZms1c205?=
 =?utf-8?B?WmxGN2locjBORmFRVFd2ZWFnNDIwQS9pVkVYQjlEdDBOTEU1QjgvckF3bUJ5?=
 =?utf-8?B?R1JxMlFkbDJISDc2WFBZZmpPTE9SSzdoNE1lZ0prd2lIQmtndjdRSXZ1a1di?=
 =?utf-8?B?Um1FcUxmOWdBZFpYSDN2K0JBcHQxSDdpVTZPejdxWWs2TU1RRm1yNjEwOGtH?=
 =?utf-8?B?amdBdkt5WllucXBTMXFPNWFwdkZ4VVpMZnYwZ2ovOXAxOExXM0FZTitGd2xL?=
 =?utf-8?B?MDl5WTRVVWs2RnpabFh0KzFnQk1oWllvNjVwcnhRdGlZZ3J5OExKbGQ3dGFv?=
 =?utf-8?B?ZlV5NldwZmFXdUNvaHlUQnlKQnpTa2RvMWIxWHBqcFJOd2lFVXNscUhsK2ds?=
 =?utf-8?Q?0QEwPKU/wYcG1Kit/iQuxYPnaxG6B5F3svZf9kL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NzREaUxNNytLTjczblNaOW83aGVvRENrb0xHWTZ2V1F1b0NrUGdMMTQ5dlV3?=
 =?utf-8?B?SVBwaDBEZmJCVzBIcC9jZzJCNGFKU0xXTVVRSUJ1Q0NaaldMNzJpcGlrWW43?=
 =?utf-8?B?aVcwK0NBVDM3d3hEeElzTzExaGdBL3MyZEFKRjJTbElUZkdyYjk3RWZtMUp0?=
 =?utf-8?B?T3FZQ2gyTGxMdndzS05yWThwTzcrQW1UMFI2aXdpS2QwaElLYWVYazIxVHlm?=
 =?utf-8?B?OHpncHNhMVp2TUJGeUcwRDhhMDl5bmtyek4wRlJrV3dLWGVQbUdLekMzVGxw?=
 =?utf-8?B?bDgwbEJDc1NsVUNqMkZqeFdObkdUVnpabkxhZ25QVVBkaUM3Q1RtSE1hdTJQ?=
 =?utf-8?B?MVhVNmxVRDBQN0JYUUZjRUtjeVZ5VjBPQmR6SG5LQU5hZVhrQkFEYjh4aCs4?=
 =?utf-8?B?Zkp2ZFdoRU5neVE4RHBrY1gzcnNIV2VjM2E3eHJRZnQ0L1JJQ2ozYm9meGFk?=
 =?utf-8?B?dmtUSEs2NlhHVmpTZ09LdDh3bU1hN1owclpuYXhIOEFXeEMvYmcrTGU2T0NF?=
 =?utf-8?B?V0djMDQ0T0JDSVl4azVxUlQzNzYvR3RHMHRwTEhaamcrVTBzZUlQOGloVE11?=
 =?utf-8?B?eW5vS2EyTDlkLzh1RHRUWnhUUGgyTTZ3QndWQjluMUFLZU5TNVFwcWRJdHB1?=
 =?utf-8?B?aUJqaVRsWnJHRDRhTmJMdVdzcWQvU2w0MlFiOGx6YnJQblNKWlR2Kys1T1Qr?=
 =?utf-8?B?ckpOTmx2T2NvbkMxL1hyYUxqSjgxdHlocmFwSXhtdUV0YWwwMXlyQjdKMDFH?=
 =?utf-8?B?cTMrUUpZUFM3NjRRd2VwT041WnRCcGJyY3dWUm0vSEdwbTRxam1kTnVwSVNL?=
 =?utf-8?B?VjI1RWRIOWNHd1lGVlFzZGg4dG9uOU9JSmVEaHZQN1RDOGk2RHM1dlFwYVQ3?=
 =?utf-8?B?dXNEQmRkSXRsbTZRSVFNaUltWU5SZGI1SWdORnF2clVSemNuYzNBREZmWEFJ?=
 =?utf-8?B?bnJRWmZnak8xL3BxelcvckJiUUR0VXZ0dG1NUGN2QjRxeVg5RmpYdnVTZnVC?=
 =?utf-8?B?aEVwQ1crNWQwSVIramdMck12OVZONGFMMll2cm02TVo4dG1ES0V6TWYrRUUy?=
 =?utf-8?B?NlkvYnQ2MndCZlBITzJNSHM0OWpHWUV4aDZmcjRVemYrRU9rejNiY0VkZFo0?=
 =?utf-8?B?TW1lTit3TjFnTjkrRzRkVkViRUlaakNhMERhdERXZHROV04xMXVZK2lDNFZx?=
 =?utf-8?B?V0xzemlNcWRtTkc5TmI2UmtiRDBuUUxmTkR0VytZWFFmdUgzS1QyY2xhakg1?=
 =?utf-8?B?cUhZY3dQaE10N3hSNGhNRWJXSmJVWjMyUWQydFZxeDlEekVtZTZnZ2xKMHNZ?=
 =?utf-8?B?clZHRVZleHZjeWl4TW9pNVVwUld2aXQwcnJxVHZQRlFQdkNycTBLdEQxbG45?=
 =?utf-8?B?cXpyNkxvVFQvSGVkbEhtc0JXNXRydlZWMUxvKytlS3V5Yld5RW42SXNWUzk3?=
 =?utf-8?B?alBndGdzNEI4aUNteURlRkFtL1FxeUtCTzNBbzJCZXVEbkJoaG5Qa0Roa3ZR?=
 =?utf-8?B?REJUSm05NlIxeUNsUHZkT2lOWk02S2VrWktGS0dPcDBWenRXbW8vUUU0a29q?=
 =?utf-8?B?TDVBeTRjN1FrdjJTTjRuNHZ4NHBMWlhoU0hpOFUzeWwyNGxpVmF3Zjhhd2Vs?=
 =?utf-8?B?cGJvRWYvWStocmNzNFo5YU4xZnNkKzJSS3h0cUZNZE5MSnVWUG9YVlZpM3Rx?=
 =?utf-8?B?Snl6dEVVQlVXUjJKVGtPYjlkR1c1VFMxQlNESVFLMTlLVFNudVhlc0dOZDhi?=
 =?utf-8?B?TGNhVVJ1UjlZK2Q3L1E2VU1hWHltdWRnd3NoU24ycUtZSlBOU29pMllqMXlV?=
 =?utf-8?B?YlJ4MU1mdXMxemoxaFJPWHlpejRpTE52VktKMDJqN0cvQ0kvUi9rb0lUR2Nu?=
 =?utf-8?B?eXJmU2ZWdUtaOUkxVlBBK0ZEMGVFNUk3Y1NZU21LWTVzTldoVk9yS1NJSnN0?=
 =?utf-8?B?TVdERlgrY1BtVGxZT3RyYlBkVFFoNU5TNi9rZ3kzU2VPNlF0Z0s3M1lxKzRL?=
 =?utf-8?B?UGw4MndIWE5HZEk2dWlnTDltbmZWK3d6ZVMrOUhnS3NoYWN6YjRaV21Hdjd2?=
 =?utf-8?B?SU9QQXBrdGUwRjhETmZ3U1Jkd0laMDBkdFNIbllPZU9BU1RuUWYrR3AxOG96?=
 =?utf-8?Q?d+qKEWpDv9F6uVe4f6zy1f1vy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421aba2a-da57-4907-c9c9-08dc860dd323
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:48:31.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVnzkbKynnKAfJeTLRUU3QowQXno/K33etCczFqvDxg7vzRbayzIl2wCoASyRmPQfh/aZX34T2+8lS5RoStKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-Proofpoint-GUID: wN_LKCz9cVeEWI8QlV6310eZ7t22h1cL
X-Proofpoint-ORIG-GUID: wN_LKCz9cVeEWI8QlV6310eZ7t22h1cL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406060072



On 2024/6/6 16:12, Arnd Bergmann wrote:
> On Thu, Jun 6, 2024, at 08:13, He Zhe wrote:
>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>> index d51fc8321d41..025a5905a370 100644
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -269,7 +269,8 @@ hpet_read(struct file *file, char __user *buf, 
>> size_t count, loff_t * ppos)
>>  	if (!devp->hd_ireqfreq)
>>  		return -EIO;
>>
>> -	if (count < sizeof(unsigned long))
>> +	if ((sizeof(int) != sizeof(long) && count < sizeof(compat_ulong_t)) ||
>> +	    (sizeof(int) == sizeof(long) && count < sizeof(unsigned long)))
>>  		return -EINVAL;
>>
>>  	add_wait_queue(&devp->hd_waitqueue, &wait);
>> @@ -294,9 +295,15 @@ hpet_read(struct file *file, char __user *buf, 
>> size_t count, loff_t * ppos)
>>  		schedule();
>>  	}
>>
>> -	retval = put_user(data, (unsigned long __user *)buf);
>> -	if (!retval)
>> -		retval = sizeof(unsigned long);
>> +	if (sizeof(int) != sizeof(long) && count == sizeof(compat_ulong_t)) {
>> +		retval = put_user(data, (compat_ulong_t __user *)buf);
>> +		if (!retval)
>> +			retval = sizeof(compat_ulong_t);
>> +	} else {
>> +		retval = put_user(data, (unsigned long __user *)buf);
>> +		if (!retval)
>> +			retval = sizeof(unsigned long);
>> +	}
> This does not look right: you are changing the behavior for
> both 32-bit and 64-bit mode, and now choose the output based
> on how many bytes userspace asked for. This has at least two
> problems:
>
> - if userspace asks for 5 to 7 bytes on a 64-bit kernel,
>   it returns 8 bytes, overflowing the provided buffer.
> - when 32-bit userspace asks for 8 or more bytes, it
>   gets 8 bytes instead of 4.
>
> Instead, you should check in_compat_syscall() to see
> which output matches the running task.

Thanks. I have should have known this helper.

v2 sent to address the above and below issues.

Regards,
Zhe

>
>> @@ -651,14 +658,23 @@ struct compat_hpet_info {
>>  	unsigned short hi_timer;
>>  };
>>
>> +#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
>> +#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)
> Right, it looks this was missing from my original change 54066a57c584
> ("hpet: kill BKL, add compat_ioctl").
>
> COMPAT_HPET_IRQFREQ should probably have a comment about the
> command code being wrong.
>
>>  	mutex_lock(&hpet_mutex);
>> -	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
>> +	err = hpet_ioctl_common(file->private_data, cmd, (unsigned 
>> long)compat_ptr(arg), &info);
>>  	mutex_unlock(&hpet_mutex);
> While this works on x86, this is not a correct use of
> compat_ptr() on architectures that modify the pointer
> in compat_ptr(). Since HPET_INFO is the only one that
> passes a pointer and that one is handled separately,
> you should just drop the compat_ptr() conversion here.
>
>     Arnd



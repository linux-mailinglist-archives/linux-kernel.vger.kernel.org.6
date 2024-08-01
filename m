Return-Path: <linux-kernel+bounces-271831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78A9453AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A01285F99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED514A4E9;
	Thu,  1 Aug 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Lf+PMer5"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C113D8B2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543475; cv=none; b=o23vns1MPEg/ysGSRGcjALawhbM5k5C7P/XmqYd8byvh62MTMcOFIBVa8J6N5L6BkCpfNWIq7xxd6/pjmP0DTrcKvCLkhh188geyrgXIoSIW0LJZ2dGKyVFfzsqlPbvM/cnsL37Z55nv3kV/k8HhrRvbfEFSGkXCmOPwM/QJ1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543475; c=relaxed/simple;
	bh=KlJ66QE+gD+xcULGhM18ezgb2XO7v3vAvYc1BcStQuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgiKT03/edfcTu+EXMgDubf2yP1wfTM7nLhzi1v3aHEfUE8Us8bzNXlqI7yeCtU/Kzbf40V8DaaKrJW3AhbDajdmFfWdwnplSzXm/KlGSD+01dxspDCn95/488od+xp7kFoKEj5C8XRH8XvxOrLOIfi3WFNjyfg6s26d0xSxssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Lf+PMer5; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id ZawBsIZ8numtXZcFEsGTws; Thu, 01 Aug 2024 20:17:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ZcFDsg2c7V2ivZcFDsS8R0; Thu, 01 Aug 2024 20:17:51 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66abed6f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=aa0rophM8MFR8eg2pQYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XVCtyLIZW5SmqXIW+p2jOuilOmSwf4QfafIqHmEkPLI=; b=Lf+PMer5bvzGF2nwhX6m0N7dc2
	1Mk0KOdwWU04jSVtnijH2N4AmF//FtjgXIZk0FpVhgME7Tvn/UmqfrfYPXWXfNUJxg5Db2C9l13Nl
	xDDpwlHutHHg5E5i6y8FDl9rUKbt6EYxKpTGxQWgmnByePAKmdaTOHFZrsGBEitAxhaQOAHxxWbpX
	3ZNGnAA6StOGHD5qJfvPHPyrDgc6dJZV3YfetPrGTGvhDlFDDL7y2xyGm4/2xwxee6VeXyWW415BS
	l7YSB+p7Ju5NYk1JMwFy4oM+H66+AWMKSzTNH7wKUQhu6YzfRkKP2Agt2qYht5ntHe37XIXsrJclp
	/Fe/goSQ==;
Received: from [201.172.173.139] (port=48040 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sZcFD-000M1F-0N;
	Thu, 01 Aug 2024 15:17:51 -0500
Message-ID: <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
Date: Thu, 1 Aug 2024 14:17:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240801190813.GC122261@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sZcFD-000M1F-0N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:48040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEmjuS4FFMEJSds8MR4GudgUcN5Dg5Ujqs5PXy3uPjTjLas7xKwKBDJNgq4/OYiM/69JBT7sRqG0dykzn5HXECsoTHXHwDzVK0RjXVeY7+Hqw7o/tJGT
 jbx6OE7ppnMV2yglLySxLuTjwm6pIo9wupGgJNuFM6vm0Sin9OWxDFozAt+Svwulc0ypjVglBoIi54zHH0bHKD3TIO4qADTDV6iHbxRGnlgmog/VnFR9w9RM



On 01/08/24 13:08, Nathan Chancellor wrote:
> On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wrote:
>>
>>
>> On 01/08/24 05:35, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
>>> head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
>>> commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
>>> config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
>>> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
>>
>>
>> Clang 20.0.0?? (thinkingface)
> 
> Indeed, Clang 19 branched and main is now 20 :)
> 
> https://github.com/llvm/llvm-project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe

Yeah, but is that a stable release?

BTW, I don't see GCC reporting the same problem below:

>>>>> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
>>>        643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>            | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>        644 |               "struct member likely outside of struct_group_tagged()");
>>>            |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>      include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
>>>         16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>>>            |                                 ^
>>>      include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>>>         77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>>            |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>      include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>>>         78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>            |                                                        ^~~~
>>>      include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
>>>        643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>            | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>        644 |               "struct member likely outside of struct_group_tagged()");
>>>            |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>      include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>>>         77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>>            |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>      include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>>>         78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>>            |                                                        ^~~~
>>>      7 warnings and 1 error generated.
>>>
>>>
>>> vim +643 include/rdma/uverbs_ioctl.h
>>>
>>>      630	
>>>      631	struct uverbs_attr_bundle {
>>>      632		/* New members MUST be added within the struct_group() macro below. */
>>>      633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
>>>      634			struct ib_udata driver_udata;
>>>      635			struct ib_udata ucore;
>>>      636			struct ib_uverbs_file *ufile;
>>>      637			struct ib_ucontext *context;
>>>      638			struct ib_uobject *uobject;
>>>      639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
>>>      640		);
>>>      641		struct uverbs_attr attrs[];
>>>      642	};
>>>    > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>>>      644		      "struct member likely outside of struct_group_tagged()");
>>>      645	
>>>
>>

Thanks
--
Gustavo


Return-Path: <linux-kernel+bounces-544843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63927A4E5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CA54221D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC5296D53;
	Tue,  4 Mar 2025 16:00:11 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48F27C15B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104010; cv=pass; b=J/BuzPAPH9lpp+fnhcgkPqq8cqLlCfEHK009wfUezX1JcmvvhJQJ+pTGOPixkfa3DM/AyaF+31CdpobXzEGwU0TsNhqvIK6h5Zj/mXNjndBMbVhtgbIT0YStCq/7HLqVWJoEkIE+ZiyvEL9mFPFUr/r8rss2xZjrZABQH+EeaTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104010; c=relaxed/simple;
	bh=ZJEojTWuFXiKxPY412FY66l7Kl1r/YJf053Gi49maqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4zXbP+SUIFB3+/hcRlmiDZJr/gHxGWipH6coZVIsYJho1y5YJ2AVkWyaNi3Au6Uaaevq5zbWzM906FjTyYkeD6gNlYcyEK1SgxJLqarhM750sQ9JpkrwEdFymWY1G+boJvJH9O2gvVxLYjAplqir1i97ctU/DOlS/CFDVz6hkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 98C5940F1CC1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:00:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gMJ5SHHzG1wL
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:58:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6EB7B42732; Tue,  4 Mar 2025 18:58:15 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541338-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id A50014367A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:07:06 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 3CFB23064C13
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:07:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614963A7FF2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321C1F37BC;
	Mon,  3 Mar 2025 10:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5A1F2B8B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996391; cv=none; b=e+yHaqjq2Cqy2zwOziw+9DS9MeuJkZ7NLhrTH5ejPJ17ZQi7h+aK+nwbDX1lsdHhUKij8EeJunq81Nk5gBfatbvbxBFHPuv3kXjXI01+vwg9bcCgc0fPBvb0lzCVoQ1qGa3oM0oZxDbmMMgQlqD2FvdFoe8O+GCEmo3N3UO6OOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996391; c=relaxed/simple;
	bh=ZJEojTWuFXiKxPY412FY66l7Kl1r/YJf053Gi49maqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFXXaixcseZQ8LcC5PPAGhq9DlWc6SXidTEz8lC9oL/g3ujBnmMP/Gmd9u4/Hf4HRhr2Y0nrlXU5EcdRBLgUiGuoDDxWxaYGMuiMqTxUKFvk/R0i3oKdEFJJr/xei9mzHPJdwGafzHaPVU3xtnt39ncp6U61wBCDieI+eFKceTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE140113E;
	Mon,  3 Mar 2025 02:06:43 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59D03F66E;
	Mon,  3 Mar 2025 02:06:28 -0800 (PST)
Message-ID: <c8a9710a-e62e-4a8f-826f-f3092824e94e@arm.com>
Date: Mon, 3 Mar 2025 11:06:27 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG Report: Fork benchmark drop by 30% on aarch64
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: abuehaze@amazon.com, linux-kernel@vger.kernel.org, wuchi.zero@gmail.com
References: <20250205151026.13061-1-hagarhem@amazon.com>
 <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
 <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
 <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
 <20250228193945.GA13237@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250228193945.GA13237@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gMJ5SHHzG1wL
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708711.7673@N/sCzaDV5E+MjUByE9lKOw
X-ITU-MailScanner-SpamCheck: not spam

On 28/02/2025 20:39, Hagar Hemdan wrote:
> On Mon, Feb 17, 2025 at 11:51:45PM +0100, Dietmar Eggemann wrote:
>> On 13/02/2025 19:55, Dietmar Eggemann wrote:
>>> On 11/02/2025 22:40, Hagar Hemdan wrote:
>>>> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
>>>>> On 10/02/2025 22:31, Hagar Hemdan wrote:
>>>>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
>>>>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
>>>>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:

[...]

>> './Run -c 4 spawn' on AWS instance (m7gd.16xlarge) with v6.13, 'mem=16G
>> maxcpus=4 nr_cpus=4' and Ubuntu '22.04.5 LTS':
>>
>> CFG_SCHED_AUTOGROUP | sched_ag_enabled | eff6c8ce8d4d | Fork (lps)
>>
>>    	y	             1		   y            21005 (27120 **)
>> 	y		     0		   y            21059 (27012 **)
>> 	n		     -		   y            21299
>> 	y		     1		   n	        27745 *
>> 	y		     0		   n	        27493 *
>> 	n		     -		   n	        20928
>>
>> (*) So here the higher numbers are only achieved when
>> 'sched_autogroup_exit_task() -> sched_move_task() ->
>> sched_change_group() is called for the 'spawn' tasks.
>>
>> (**) When I apply the fix from
>> https://lkml.kernel.org/r/4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com.
> 
> This is currently impacting our kernel, do you
> have any concerns to submit this fix upstream?

Will send it out after the analysis now done. See the other email from
today.



Return-Path: <linux-kernel+bounces-544451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E68A4E16E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8500C3A439C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AD25FA1A;
	Tue,  4 Mar 2025 14:34:13 +0000 (UTC)
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E02627F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098852; cv=pass; b=XyZsGMKZUaXE+4fy4RvFMtAlNV6vfHMuVQ1lLH/CcwCzUHVEZa+PosbEYP2mwMBdioZbR/IDuqvZWzv5e2B33G3d7eKMwv6MXG0F6as9F8OMB8/jdaAshfSEXXh1UsZ7g+rsVk8LrxPcBXl+ib66ixo7t+JpQowIilDKqe0ipwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098852; c=relaxed/simple;
	bh=AoU4Z3QCQ2/qu0GeNzrhNZiZ91wW/kwe2RXf1SNdPPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDiMeVUdVB43m9sPVuV3yiI10CVq5sxgCJDXvmEpTf+ps7LlOmyjZLskcDvIr+ZSN2qSWt+pfAif38G8bvACBTuW2Y9BFXKu8GV6kBdeLO4TfqCK8K7Jfx6c38ox4jRE4PHXYK4XyEbJ4J+Sdo+fE4AFx5qef+qG9cLGD2UdPjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9332140CF109
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:34:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dSX2xJyzFwx8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:32:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B83C742727; Tue,  4 Mar 2025 17:32:37 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541334-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1BD3942239
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:05:27 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C5BB43064C15
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:05:26 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283CC167653
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530091F193C;
	Mon,  3 Mar 2025 10:05:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E121EE7DF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996313; cv=none; b=ovaee2DoIGaflmXgw3cOPqdp/17Wq5lbgluoDO+1uKTSLMmxopOjuxbH5rqikXM7w5h+2BsGgWQXtbHu2NJUYalkOC7QElkJ8NDKjKFoHKafZ7NojzCF/wJ7lv/gwBz2HYgg4l8LIuvP+uWyFm5pyNEOjf9Yxb+948ARWhZ4yP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996313; c=relaxed/simple;
	bh=AoU4Z3QCQ2/qu0GeNzrhNZiZ91wW/kwe2RXf1SNdPPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGL6L1dmJC9DTj4JbrUYdRyzDnLKM+6miKLT3XW47yULJ7Hv6IL5D/j+vpWCbi4eLl5YQog96ICCb1Q1OAO5KsrC1ZSGM03k1+4UbZOUNGFkP4tKCQl7DLfE56CsKmB9CAWALtL9+zZJ1YmBL69wEYN/QJqMBuuJwIbU2s/knLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87288113E;
	Mon,  3 Mar 2025 02:05:25 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96123F66E;
	Mon,  3 Mar 2025 02:05:10 -0800 (PST)
Message-ID: <14a2aaac-05d5-4b2e-a8c1-617bb4411659@arm.com>
Date: Mon, 3 Mar 2025 11:05:01 +0100
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
Cc: abuehaze@amazon.com, wuchi.zero@gmail.com, linux-kernel@vger.kernel.org
References: <20250205151026.13061-1-hagarhem@amazon.com>
 <4a9cc5ab-c538-4427-8a7c-99cb317a283f@arm.com>
 <20250207110754.GA10452@amazon.com>
 <1ca758c7-b6ab-4880-9cc7-217093a30bbb@arm.com>
 <20250210213155.GA649@amazon.com>
 <4b48fd24-6cd5-474c-bed8-3faac096fd58@arm.com>
 <20250211214019.GA15530@amazon.com>
 <75503128-c898-4da7-ab99-55f4ef6e2add@arm.com>
 <5f92761b-c7d4-4b96-9398-183a5bf7556a@arm.com>
 <20250221064436.GA485@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250221064436.GA485@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dSX2xJyzFwx8
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703567.66059@X/3HFE622XNZXtWJHc0eIA
X-ITU-MailScanner-SpamCheck: not spam

On 21/02/2025 07:44, Hagar Hemdan wrote:
> On Mon, Feb 17, 2025 at 11:51:45PM +0100, Dietmar Eggemann wrote:
>> On 13/02/2025 19:55, Dietmar Eggemann wrote:
>>> On 11/02/2025 22:40, Hagar Hemdan wrote:
>>>> On Tue, Feb 11, 2025 at 05:27:47PM +0100, Dietmar Eggemann wrote:
>>>>> On 10/02/2025 22:31, Hagar Hemdan wrote:
>>>>>> On Mon, Feb 10, 2025 at 11:38:51AM +0100, Dietmar Eggemann wrote:
>>>>>>> On 07/02/2025 12:07, Hagar Hemdan wrote:
>>>>>>>> On Fri, Feb 07, 2025 at 10:14:54AM +0100, Dietmar Eggemann wrote:
>>>>>>>>> Hi Hagar,
>>>>>>>>>
>>>>>>>>> On 05/02/2025 16:10, Hagar Hemdan wrote:

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
> Thanks!
> Will you submit that fix upstream?

I will, I just had to understand in detail why this regression happens.

Looks like the issue is rather related to 'sgs->group_util' in
group_is_overloaded() and group_has_capacity(). If we don't
'deqeue/detach + attach/enqueue' (1) the task in sched_move_task() then
sgs->group_util is ~900 (you run 4 CPUs flat in a single MC sched domain
so sgs->group_capacity = 1024 and this leads to group_is_overloaded()
returning true and group_has_capacity() false much more often as if
we would do (1).

I.e. we have much more cases of 'group_is_overloaded' and
'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
then (a) returns much more often a CPU != smp_processor_id() (which
isn't good for these extremely short running tasks (FORK + EXIT)) and
also involves calling sched_balance_find_dst_group_cpu() unnecessary
(since we deal with single CPU sched domains). 

select_task_rq_fair(..., wake_flags = WF_FORK)

  cpu = smp_processor_id()

  new_cpu = sched_balance_find_dst_group(..., cpu, ...)

    do {

      update_sg_wakeup_stats()

        sgs->group_type = group_classify()   
							w/o patch 	w/ patch                   
          if group_is_overloaded() (*)
            return group_overloaded /* 6 */		457,141		394

          if !group_has_capacity() (**)
            return group_fully_busy /* 1 */ 	  	816,629		714

          return group_has_spare    /* 0 */		1,158,890	3,157,472

    } while group 

    if local_sgs.group_type > idlest_sgs.group_type	
      return idlest					351,598		273

    case group_has_spare:

      if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
        return NULL 					156,760		788,462


(*)

  if sgs->group_capacity * 100) <			
		sgs->group_util * imbalance_pct		951,705		856
    return true

  sgs->group_util ~ 900 and sgs->group_capacity = 1024 (1 CPU per sched group)


(**)

 if sgs->group_capacity * 100 >
		sgs->group_util * imbalance_pct
   return true						1,087,555	3,163,152

 return false						1,332,974	882


(*) and (**) are for 'wakeup' and 'load-balance' so they don't
match the only wakeup numbers above!

In this test run I got 608,092 new wakeups w/o and 789,572 (~+ 30%)
w/ the patch when running './Run -c 4 -i 1 spawn' on AWS instance
(m7gd.16xlarge) with v6.13, 'mem=16G maxcpus=4 nr_cpus=4' and
Ubuntu '22.04.5 LTS'

> Do you think that this fix is the same as reverting commit eff6c8ce8d4d and
> its follow up commit fa614b4feb5a? I mean what does commit eff6c8ce8d4d 
> actually improve?

There are occurrences in which 'group == tsk->sched_task_group' and
'!(tsk->flags & PF_EXITING)' so there the early bail might help w/o
the negative impact on sched benchmarks.



Return-Path: <linux-kernel+bounces-405094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44749C4CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AE51F2195E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204920720F;
	Tue, 12 Nov 2024 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e3Bp+zDB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2619F489
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380051; cv=none; b=kF/CnO9t13sHFFmkHzYYZim3mTsC4uquZvM3MG2ksaFUZ48qZmc9ES5tiIN1vJKY+o71REMDohEzUNXxriKIu0gRYcbfWSo4MToMf2ojxzX9XiqDh67rTVJRDFW1IXVjGyYdvpKIjNO1BUxzBREGgt1XZ9bj9G+y8iv2VP3stgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380051; c=relaxed/simple;
	bh=wlbvrhqyWyTvnCkoAxzxk1XF4fc0oJTGZ1qf5xAYkWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5NHmxTi8IrRr3lzOzFcMnQThDRqYDAopuklMWNUrC9iWaE1S3Ol58X/sGKvFEJ+Vs6v4ZO2uZjMUhMygEYFEX8btbM4iPsvmQwCSylPm0MRV/Wyz9L0GNlll3LAX5lsRk6t5E4+8MCRlBFk6m1vIP3fKDNKpzEBglMMiu1UEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=e3Bp+zDB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AC2r93F3134183
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 11 Nov 2024 18:53:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AC2r93F3134183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731379991;
	bh=gjorSsxchh+ht/kZ7ZaoFSuF5phuCVrV0xf71JxGrKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e3Bp+zDBUBc7t8gSWsAhOHpGiz0jxnlMUf3VfEm8JKCFYxBffzsXvcR9zQbzDk977
	 /m+F2GDcomvYNCAUaL6T15PQrHe2q92yDhWWekgLC95WqKi5JPdV05IxpCd7qZo6i7
	 Qu+wViP/q82NKcdfSip9eB35A568wGEClK74jAOEuu92gdIxunNtGmkQTHLKIGaT1u
	 wXjRH0IBMJnsfFlqK/2wLG1jieL+rxE3V5D+HljOrd518oxkwjt8mWEwbtScnoNkEq
	 MCNi67i2EMX6wZzFhUQZxmc3Ck+erSU94EejGbT+9/0UChcgRBS+4c4S6zNf7MKbOU
	 prZ/TdGjVxpmA==
Message-ID: <6735d24c-b031-499d-b298-ef8861b4daba@zytor.com>
Date: Mon, 11 Nov 2024 18:53:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
To: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org
References: <20240916181000.416513-1-xin@zytor.com>
 <49b6c23b-dfd8-4874-bd6e-998dd039ed1a@zytor.com>
 <473f9dae-b711-4d96-8804-209275b963a2@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <473f9dae-b711-4d96-8804-209275b963a2@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/2024 12:53 PM, Andrew Cooper wrote:
>> Andrew,
>>
>> can you please take another look?
> After discussing with Dave on IRC, the ibt_clear_fred_wfe(regs); really
> needs to be inside the ibt_selftest_noendbr path.
> 

Sigh, I missed the discussion.

> It's a selftest where we're deliberately trying to trigger #CP, and in
> the one case where we're happy should we say "yeah, safe to clobber WFE
> in the interrupted context" to let execution continue.
> 
> Clobbering WFE in any other circumstance is a security-relevant bug.

I think we also need to clear WFE when !ibt_fatal.  No?

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index fb8f4238969e..69a34636811f 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -128,6 +128,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, 
unsigned long error_code)
	if (!ibt_fatal) {
		printk(KERN_DEFAULT CUT_HERE);
		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		ibt_clear_fred_wfe(regs);
		return;
	}
	BUG();



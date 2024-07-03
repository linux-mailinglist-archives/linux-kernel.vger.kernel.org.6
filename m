Return-Path: <linux-kernel+bounces-240360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E7926CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C50281E14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F44C76;
	Thu,  4 Jul 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="M+lS2mKo"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14351802
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052460; cv=none; b=fekkx/fiT0a0g4FGALLFSTEDyGtvI4l/gw6UUjNZfq9CFU/8g4DuRLreTNdpkBFW4e6uMZhEtENU2ckda86hpsWdF8Hgv5Vl5Mlcp/v73VxFyMEmjPNSE1kf1CMyDVUBPrb9Vl0kIx37w+hfkiLdlsSdNXW6cHme6EpfDzI1i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052460; c=relaxed/simple;
	bh=6KK7oTY/cTJHENP66oVTWy9znLaOryTeOiG1rRIYNcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jen0hqP7mb6rzK6+2QSKftjGQyyyRVII2YRuns+i4f3uCXgBdcDvA13uGKRKtI2sBW82aI8bHtdeHqO0tLMwHo+fjDFbpZE1Hj64YZkp3/aISS4JJ7YNmy5KUwfJnQuz1wg6SYbCXS4vp0k1Y2lh2M12lroo1aUttwGhickNcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=M+lS2mKo; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 463Mm4C21070766
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jul 2024 15:48:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 463Mm4C21070766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720046886;
	bh=Mt7iDqDbKs8II8sIWBE5dbgK5jzEx5l8Qan/TPvdsXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M+lS2mKo5BsSrDDfOvlbWHP8CSfO5g3C7HHm03HUBcxP3driqF7d2WLbbuG2sARjy
	 GOcwkdMI6pmTXU4d7m1BTkrJKjAKXm3sZ3ZM8f1HicJ3mz1auHXlulMuppkdVzEL3v
	 VUvmsPIMOT/FNlMcp0Gs/Tv8xx187luETD1GbWO6hpaJYHIPGOn9Rb2PQKUc/xgGHY
	 /Zl88IBRIx0ugVIV+Fc1M1+b+4w/zy9bl65p2wNWIu2m+CDL+CDzKDM6R69zlSZ7Xd
	 cWxYB8VE71E2Gzo57VyOfHKcY6bozAQWrOkRrLA73YD0sB0GXl0nI7xbVQ1Ed9HuJS
	 iazqfRZTcTaOQ==
Message-ID: <c5f3a503-ac48-4d4d-9ef1-cddc5c7d0ab8@zytor.com>
Date: Wed, 3 Jul 2024 15:48:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
To: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        nik.borisov@suse.com, houwenlong.hwl@antgroup.com
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
 <dc1b2c50-6172-46a1-98a8-cec729afff38@intel.com>
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
In-Reply-To: <dc1b2c50-6172-46a1-98a8-cec729afff38@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/2024 9:43 AM, Dave Hansen wrote:
> On 7/3/24 09:06, H. Peter Anvin wrote:
>> I believe tglx declared to use them unconditionally since FRED> depends on WRMSRNS (and the kernel enforces that.)
> 
> Ahh, I forgot about:
> 
> static const struct cpuid_dep cpuid_deps[] = {
> 	...
>          { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },
> 
> So, yeah, Xin's patch here is quite safe and when Boris said:
> 
>> Also, all those wrmsrns() writes better be behind a CPUID check.
> 
> ... it *is* behind a CPUID check, but it's an implicit one.
>

Right!

Otherwise typically there will be two feature checks in a line in the 
source code (the run time code is binary patched):

	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
		if (cpu_feature_enabled(X86_FEATURE_WRMSRNS))
			wrmsrns(MSR_IA32_FRED_RSP0, ...);
		else
			wrmsrl(MSR_IA32_FRED_RSP0, ...);
	}


Yes, Andrew's idea to use alternative_input() is a clean approach that
everyone has agreed.  However there is a more fundamental problem with
how WRMSR instruction is being used in the existing code:
   https://lore.kernel.org/lkml/87y1h81ht4.ffs@tglx/.

My rough understanding is that first we want something like:
	alternative_input("call paravirt_write_msr", "wrmsr", X86_FEATURE_XENPV);
to get PVOPS out of the picture, and then apply alternative_input() as
Andrew proposed.

I thought about giving it a shot, but it never comes to the top of my
task list.

Thanks!
     Xin


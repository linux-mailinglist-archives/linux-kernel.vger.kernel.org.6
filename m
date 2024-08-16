Return-Path: <linux-kernel+bounces-290418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F8955394
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE86F1F22340
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF414658C;
	Fri, 16 Aug 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DIp0Bk0S"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227A1465A1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849185; cv=none; b=k511beJLQiM1E6se7OTLXoksuhIuwxsevJA2pFAzyx+m4vAs0Nfy3i634dEsm4Xxzv6Sa5BKYf1DTPWB2lOQHAgqQ/Z9w2MOWThMMTgtl2KGijTOcJQyNUnKQBb4QxeX0lJmBAYUsU7tWMvXIf6U9PZY8sQW7CDL+hmup3BXCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849185; c=relaxed/simple;
	bh=q9dGdI+a9ruKCT/Pd6WqbLrOZnRXug3ezDFnwtEYKqU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZArUYHmLdMZZLL6rXpm3MxDeZPz1n0DfYi1OaPH2U1Roj/MXjmN/BsCe+47msSCFF3aelY77Jcm476xyPfCIarzYTWi0KSmX21PnWoGgKmeUhqpApYFoEXFXoVBch93F2WNpSvm9HKBkOzGxrtlFfczNfzwEfaft+yI8hYyctgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DIp0Bk0S; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47GMx8Xe3561042
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 Aug 2024 15:59:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47GMx8Xe3561042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723849149;
	bh=PeIAtbUXlvtM8Q1oZNGKGK1GqFujXMVa5+rC/+/cHuw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DIp0Bk0S0rvkL/OpkaNKFBdhuMh4WdUI5zPMbeMoAoR05i6UjO49Q/HoZVFraehDZ
	 BJqYIgsr6AHlzmCF3b+cEayrsIF8IqAF93MIpU+hyVXuVarshTem0FEwydI3evlhdF
	 MQKMKUa26M9PQ2FzRtpu8RduCMbWUmAdn0jjDgpCHy/f1IAP9DBUIfi48qzqxFKLO9
	 NH5c6h0j9+8YSRDUybCHM3Amkfk1UYS5mSfT1MIWf/vhb76fwhiQSHeCOkO39AMa+U
	 rDmaIY5QPPYK+uOBEOpSlJkH57SE7MNvMlrSyZzfD0ZnniIzd9vmq15YrrZDdtUeAJ
	 27dqatFK2M0eQ==
Content-Type: multipart/mixed; boundary="------------xWwaBzuzwwo7uc0o0B4pxEho"
Message-ID: <0ec48b84-d158-47c6-b14c-3563fd14bcc4@zytor.com>
Date: Fri, 16 Aug 2024 15:59:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
 <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>
Content-Language: en-US
In-Reply-To: <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>

This is a multi-part message in MIME format.
--------------xWwaBzuzwwo7uc0o0B4pxEho
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/16/24 14:26, H. Peter Anvin wrote:
> On 8/16/24 11:40, Andrew Cooper wrote:
>>>
>>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>>
> 
> You can use up to 4 prefixes of any kind (which includes opcode prefixes 
> before 0F) before most decoders start hurting, so we can pad it out to 5 
> bytes by doing 3f 3f .. .. ..
> 
>>
>> My suggestion, not that I've had time to experiment, was to change
>> paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
>> edx:eax into rsi.  That way the top level wrmsr() retains sensible
>> codegen for native even when paravirt is active.
>>
> 
> I have attached what should be an "obvious" example... famous last words.
> 

After looking at what xen_do_write_msr looks like, I realized we can do 
*much* better than that. This means using two alternative sequences, one 
for native/Xen and the other for native wrmsr/wrmsrns.

The call/jz sequence is *exactly* the same length as mov, shr, which 
means that xen_do_write_msr can simply return a flag if it wants the MSR 
access to be performed natively.

An important point is that in no code path can the error code be set to 
-EIO except by native MSR invocation, so the only possibilities are 
"done successfully" or "execute natively." [That being said, that would 
not be *that* hard to fix if needed.]

The new C prototype for xen_do_write_msr() becomes:

bool xen_do_write_msr(uint32_t msr, uint64_t val)

... with a true return meaning "execute natively."

(I changed the order of the arguments from my last version since it is 
more consistent with what is used everywhere else.)

RDMSR is a bit trickier. I think the best option there is to set up a 
new permission trap handler type that amounts to "get the address from 
the stack, apply a specific offset, and invoke the fixup handler for 
that address:


	case EX_TYPE_UPLEVEL: {
		/* Let reg hold the unsigned number of machine
		 * words to pop off the stack before the return
		 * address, and imm the signed offset from the
		 * return address to the desired trap point.
		 *
		 * pointer in units of machine words, and imm the
		 * signed offset from this stack word...
		 */
		unsigned long *sp = (unsigned long *)regs->sp + reg;
		regs->ip = *sp++ + (int16_t)imm;
		regs->sp = (unsigned long)sp;
		goto again;	/* Loop back to the beginning */
	}

Again, "obviously correct" code attached.

	-hpa

NOTE:

I had to dig several levels down to uncover actual situation, but 
pmu_msr_write() is actually a completely pointless function: all it does 
is shuffle some arguments, then calls pmu_msr_chk_emulated() and if it 
returns true AND the emulated flag is clear then does *exactly the same 
thing* that the calling code would have done if pmu_msr_write() itself 
had returned true... in other words, the whole function could be 
replaced by:

bool pmu_msr_write(uint32_t msr, uint64_t val)
{
         bool emulated;

         return pmu_msr_chk_emulated(msr, &val, false, &emulated) &&
  	       emulated;
}

pmu_msr_read() does the equivalent stupidity; the obvious fix(es) to 
pmu_msr_chk_emulated() I hope are obvious.



--------------xWwaBzuzwwo7uc0o0B4pxEho
Content-Type: text/plain; charset=UTF-8; name="xen.S"
Content-Disposition: attachment; filename="xen.S"
Content-Transfer-Encoding: base64

LyoKICogSW5wdXQgaW4gJXJheCwgTVNSIG51bWJlciBpbiAlZWN4CiAqCiAqICVlZHggaXMg
c2V0IHVwIHRvIG1hdGNoICVyYXggPj4gMzIgbGlrZSB0aGUgbmF0aXZlIHN0dWIKICogaXMg
ZXhwZWN0ZWQgdG8gZG8KICoKICogQ2hhbmdlIHhlbl9kb193cml0ZV9tc3IgdG8gcmV0dXJu
IGEgdHJ1ZSB2YWx1ZSBpZgogKiB0aGUgTVNSIGFjY2VzcyBzaG91bGQgYmUgZXhlY3V0ZWQg
bmF0aXZlbHkgKG9yIHZpY2UgdmVyc2EsCiAqIGlmIHlvdSBwcmVmZXIuKQogKgogKiBib29s
IHhlbl9kb193cml0ZV9tc3IodWludDMyX3QgbXNyLCB1aW50NjRfdCB2YWx1ZSkKICoKICog
TGV0IHRoZSBuYXRpdmUgcGF0dGVybiBsb29rIGxpa2U6CiAqCiAqIDQ4IDg5IGMyICAgICAg
ICAgICAgICAgIG1vdiAgICAlcmF4LCVyZHgKICogNDggYzEgZWEgMjAgICAgICAgICAgICAg
c2hyICAgICQzMiwlcmR4CiAqIDNlIDBmIDMwICAgICAgICAgICAgICAgIGRzIHdybXNyCQk8
LS0tIHRyYXAgcG9pbnQKICoKICogLi4uIHdoaWNoIGNhbiBiZSByZXBsYWNlZCB3aXRoIC4u
LgogKiA0OCA4OSBjMiAgICAgICAgICAgICAgICBtb3YgICAgJXJheCwlcmR4CiAqIDQ4IGMx
IGVhIDIwICAgICAgICAgICAgIHNociAgICAkMzIsJXJkeAogKiAwZiAwMSBjNiAgICAgICAg
ICAgICAgICB3cm1zcm5zCQk8LS0tIHRyYXAgcG9pbnQKICoKICogRk9SIFhFTiwgcmVwbGFj
ZSB0aGUgRklSU1QgU0VWRU4gQllURVMgd2l0aDoKICogZTggeHggeHggeHggeHggICAgICAg
ICAgY2FsbCBhc21feGVuX3dyaXRlX21zcgogKiA3NCAwMyAgICAgICAgICAgICAgICAgICBq
eiAuKzUKICoKICogSWYgWkY9MCB0aGVuIHRoaXMgd2lsbCBmYWxsIGRvd24gdG8gdGhlIGFj
dHVhbCBuYXRpdmUgV1JNU1JbTlNdCiAqIGluc3RydWN0aW9uLgogKgogKiBUaGlzIGFsc28g
cmVtb3ZlcyB0aGUgbmVlZCBmb3IgWGVuIHRvIG1haW50YWluIGRpZmZlcmVudCBzYWZlIGFu
ZAogKiB1bnNhZmUgTVNSIHJvdXRpbmVzLCBhcyB0aGUgZGlmZmVyZW5jZSBpcyBoYW5kbGVk
IGJ5IHRoZSBzYW1lCiAqIHRyYXAgaGFuZGxlciBhcyBpcyB1c2VkIG5hdGl2ZWx5LgogKi8K
IFNZTV9GVU5DX1NUQVJUKGFzbV94ZW5fd3JpdGVfbXNyKQoJRlJBTUVfQkVHSU4KCXB1c2gg
JXJheAkJLyogU2F2ZSBpbiBjYXNlIG9mIG5hdGl2ZSBmYWxsYmFjayAqLwoJcHVzaCAlcmN4
CglwdXNoICVyc2kKCXB1c2ggJXJkaQoJcHVzaCAlcjgKCXB1c2ggJXI5CglwdXNoICVyMTAK
CXB1c2ggJXIxMQoJbW92ICVlY3gsJWVkaQkJLyogTVNSIG51bWJlciAqLwoJbW92ICVyYXgs
JXJzaQkJLyogTVNSIGRhdGEgKi8KCWNhbGwgeGVuX2RvX3dyaXRlX21zcgoJdGVzdCAlYWws
JWFsCQkvKiBaRj0xIG1lYW5zIHdlIGFyZSBkb25lICovCglwb3AgJXIxMQoJcG9wICVyMTAK
CXBvcCAlcjkKCXBvcCAlcjgKCXBvcCAlcmRpCglwb3AgJXJzaQoJcG9wICVyY3gKCW1vdiA0
KCVyc3ApLCVlZHgJLyogU2V0IHVwICVlZHggZm9yIG5hdGl2ZSBleGVjdXRpb24gKi8KCXBv
cCAlcmF4CglGUkFNRV9FTkQKCVJFVApTWU1fRlVOQ19FTkQoYXNtX3hlbl93cml0ZV9tc3Ip
CgovKgogKiBSRE1TUiBjb2RlLiBJdCBpc24ndCBxdWl0ZSBhcyBjbGVhbjsgaXQgcmVxdWly
ZXMgYSBuZXcgdHJhcCBoYW5kbGVyCiAqIHR5cGU6CiAqCiAqCWNhc2UgRVhfVFlQRV9VUExF
VkVMOiB7CiAqCQkvKiBMZXQgcmVnIGhvbGQgdGhlIHVuc2lnbmVkIG51bWJlciBvZiBtYWNo
aW5lCiAqCQkgKiB3b3JkcyB0byBwb3Agb2ZmIHRoZSBzdGFjayBiZWZvcmUgdGhlIHJldHVy
bgogKgkJICogYWRkcmVzcywgYW5kIGltbSB0aGUgc2lnbmVkIG9mZnNldCBmcm9tIHRoZQog
KgkJICogcmV0dXJuIGFkZHJlc3MgdG8gdGhlIGRlc2lyZWQgdHJhcCBwb2ludC4KICoJCSAq
CiAqCQkgKiBwb2ludGVyIGluIHVuaXRzIG9mIG1hY2hpbmUgd29yZHMsIGFuZCBpbW0gdGhl
CiAqCQkgKiBzaWduZWQgb2Zmc2V0IGZyb20gdGhpcyBzdGFjayB3b3JkLi4uCiAqCQkgKiAv
CiAqCQl1bnNpZ25lZCBsb25nICpzcCA9ICh1bnNpZ25lZCBsb25nICopcmVncy0+c3AgKyBy
ZWc7CiAqCQlyZWdzLT5pcCA9ICpzcCsrICsgKGludDE2X3QpaW1tOwogKgkJcmVncy0+c3Ag
PSAodW5zaWduZWQgbG9uZylzcDsKICoJCWdvdG8gYWdhaW47CS8qIExvb3AgYmFjayB0byB0
aGUgYmVnaW5uaW5nICogLwogKgl9CiAqCiAqIFRoZSBwcm90b3R5cGUgb2YgdGhlIFhlbiBD
IGNvZGU6CiAqIHN0cnVjdCB7IHVpbnQ2NF90IHZhbCwgYm9vbCBuYXRpdmUgfSB4ZW5fZG9f
cmVhZF9tc3IodWludDMyX3QgbXNyKQogKgogKiBOYXRpdmUgY29kZToKICogMGYgMzIgICAg
ICAgICAgICAgICAgICAgcmRtc3IJPC0tLSB0cmFwIHBvaW50CiAqIDQ4IGMxIGUyIDIwICAg
ICAgICAgICAgIHNobCAgICAkMHgyMCwlcmR4CiAqIDQ4IDA5IGQwICAgICAgICAgICAgICAg
IG9yICAgICAlcmR4LCVyYXgKICoKICogWGVuIGNvZGUgKGNzIHJleCBpcyBqdXN0IGZvciBw
YWRkaW5nKQogKiAyZSA0MCBlOCB4eCB4eCB4eCB4eCAgICBjcyByZXggY2FsbCBhc21feGVu
X3JlYWRfbXNyCiovCgpTWU1fRlVOQ19TVEFSVChhc21feGVuX3JlYWRfbXNyKQoJRlJBTUVf
QkVHSU4KCXB1c2ggJXJjeAoJcHVzaCAlcnNpCglwdXNoICVyZGkKCXB1c2ggJXI4CglwdXNo
ICVyOQoJcHVzaCAlcjEwCglwdXNoICVyMTEKCW1vdiAlZWN4LCVlZGkJCS8qIE1TUiBudW1i
ZXIgKi8KCWNhbGwgeGVuX2RvX3JlYWRfbXNyCgl0ZXN0ICVkbCwlZGwJCS8qIFpGPTEgbWVh
bnMgd2UgYXJlIGRvbmUgKi8KCXBvcCAlcjExCglwb3AgJXIxMAoJcG9wICVyOQoJcG9wICVy
OAoJcG9wICVyZGkKCXBvcCAlcnNpCglwb3AgJXJjeAoJanogMmYKMToKCXJkbXNyCglfQVNN
X0VYVEFCTEVfVFlQRSgxYiwgMmYsIFwKCQlFWF9UWVBFX1VQTEVWRUx8RVhfREFUQV9JTU0o
LTcpfEVYX0RBVEFfUkVHKDApKQoJc2hsICQzMiwlcmR4CglvciAlcmR4LCVyYXgKCS8qCgkg
KiBUaGUgdG9wIG9mIHRoZSBzdGFjayBwb2ludHMgZGlyZWN0bHkgYXQgdGhlIHJldHVybiBh
ZGRyZXNzOwoJICogYmFjayB1cCBieSA3IGJ5dGVzIGZyb20gdGhlIHJldHVybiBhZGRyZXNz
LgoJICovCjI6CglGUkFNRV9FTkQKCVJFVApTWU1fRlVOQ19FTkQoYXNtX3hlbl9yZWFkX21z
cikK

--------------xWwaBzuzwwo7uc0o0B4pxEho--


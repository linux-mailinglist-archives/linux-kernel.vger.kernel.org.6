Return-Path: <linux-kernel+bounces-414281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BC9D25B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5F11F23BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DC1CBEA9;
	Tue, 19 Nov 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="Bbl4r1vo"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD7157472;
	Tue, 19 Nov 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019185; cv=none; b=XLDBs61r/ozCYUeqyT9HJbhSU2Fwk1hwpHHItujMXXHFJ7pyV22yaKOFbFVZfRWOeLixCp0lyUS/fPmYK7ae3ON13IEKcPUh2akCgpT2GGe3//txplWBLvXBJ1QlePa1moTSyLFSMPk9CnJV37lR0H8+VpAYovmyVKGGhgUmztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019185; c=relaxed/simple;
	bh=GovRAiy3DraGCAKwBagDHabFcUxUxipmdlzRXOvxL7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF8rBbUkYXsRaUaOwHkDOSeGA1hfAxDzxcAERBrWzRGNGo4zf3fNwkTHCV6FbKAu7nPHbJbsOWQhEw5+3PMmr/uU28FhYnKRay7hw9yjsf6rp1W3VtGU9BsxwZCf82yNTwzfQV4sMDcvyN5/t2BLDQDa0MlDSMQBKg1efobpO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=Bbl4r1vo; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id EF2BE43473;
	Tue, 19 Nov 2024 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1732019171;
	bh=GovRAiy3DraGCAKwBagDHabFcUxUxipmdlzRXOvxL7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bbl4r1vorJpVPxC0gJK4HKH/Ve934lglLUSkTtREVdT60CAVy7E8Zpw4/I7jKoDgB
	 ctmoV4XLius7qljCIr561tGS/eCff5TfcvVC1LfF0Pk80fojUeV+y58y+6fr525X27
	 QK1zg/ewWXkTxw3kMI6ZkXpOpAdq7sos0uueTBkII5twvWmr14a02qFoK9T4+pU8/r
	 lXCyTHbWFZGQAA2kLgcSWWr9LHtAM+tMgHz2P6mEvuGd7r4EdQk61GTKXS4wuvX/kz
	 d5Gbl8awrd3jPjNNsJpUxIoGRrzhLMChNTms/jsKGUVMNeb/hpnNMuBE2ggXve6s6w
	 zwBmtbV8nYEDg==
Message-ID: <962f49a8-0d0c-4a1d-836f-e12c0f621917@asahilina.net>
Date: Tue, 19 Nov 2024 21:26:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
 <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
 <b4c1e64b-daef-4181-a3fb-98b4ab3a9c1e@igalia.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <b4c1e64b-daef-4181-a3fb-98b4ab3a9c1e@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/19/24 8:11 PM, Maíra Canal wrote:
> Hi Tamir & Miguel,
> 
> On 18/11/24 14:02, Tamir Duberstein wrote:
>> On Mon, Nov 18, 2024 at 11:52 AM Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> On Mon, Nov 18, 2024 at 5:33 PM Tamir Duberstein <tamird@gmail.com>
>>> wrote:
>>>>
>>>> This is a reimagining relative to earlier versions[0] by Asahi Lina and
>>>> Maíra Canal.
>>>
>>> Maíra's latest version has both of them listed as co-authors in the
>>> main patch -- how close is this to that version? (I see some bits that
>>> look fairly similar)
>>>
>>> Thanks!
>>>
>>> Cheers,
>>> Miguel
>>
>> It's fairly different, and I discussed with both of them - we agreed
>> that Co-developed-by would not be appropriate.
> 
> I still agree that a Co-developed-by isn't appropriate, but I believe
> that it would be fair to mention me and Lina on the commit message.

I think I mentioned Inspired-by: as perhaps a nice alternative?

> 
> Best Regards,
> - Maíra
> 
>>
>> Thanks!
>> Tamir
> 
> 

~~ Lina



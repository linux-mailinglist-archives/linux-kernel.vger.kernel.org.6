Return-Path: <linux-kernel+bounces-362627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9499B71F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9871C20FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7114D6ED;
	Sat, 12 Oct 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b="k4sZw0C9"
Received: from dd3514.kasserver.com (dd3514.kasserver.com [85.13.129.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370458F49;
	Sat, 12 Oct 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.129.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728767687; cv=none; b=evjT8M3vmEFKc0t0S6w4AqwQwxHn3OTjshdTCQ3+xDmSONjDc6lrABMWJckriCVUv5FtGrw0DIYe7ng1Qe8SdyLwsKEo1o1Htk8b9Voa44m1WT9a57PBWfipbOdQ7mlkuVAplEshKX/hp1U72fAmnR6wWWQtEIcPt4vol8Aw2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728767687; c=relaxed/simple;
	bh=/NUcAbKwbXJ/iTal7F66He+nrF+0nzhzv/w9IiUiG6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JawadwcSSQBUKC8G33aJ3WHiph6qWTlly4tMXprFjVk8bHoWNWKisG2+UHEaqUY0MAzuAHlSj+Op/aX2H8nQmUXgPiBNeILCtF46Tz/+5vSnUYCQvCdhmnehd4xdy8ryMhDioJPq0lEGHnBUuMNtrOY2IBX135hLT38sDHfMS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com; spf=pass smtp.mailfrom=walterzollerpiano.com; dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b=k4sZw0C9; arc=none smtp.client-ip=85.13.129.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walterzollerpiano.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=walterzollerpiano.com; s=kas202409051210; t=1728767675;
	bh=Zm8qSnzI2p/5ZwMZ87hk/+G3XVX5j1FDxMimTthXlxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k4sZw0C9nIKaTnI3R3tlqol+Pv/jYgN8fLvlNTaDsTnJ/jZw/dkcVMt9ZCfL2RCxP
	 g7MYnLzeGuz2lt5w2VsNh8lW0lB4/bLNfZ08/XRwOqAL9CPfRDpRd8VTd0nxkUizMq
	 pM39HH0P5h1bKgKIFznLczCMs7dYEgyxkrjsnMjkxReXNnPcAsV34pWnGqIWv7LIoT
	 etJz++8erBukkSqI03Ov7l2tPLfyoPKLxJoaf0V8gRB5lkBFXSRFFcnwn/3AQi/ogt
	 JbuZZr8RIMdMk1iBniqq6sjy5+8QHeiyBxFq9lbFEsFoMdPuUaUDe4uU76A+XFS7No
	 oi4XAGG8UpMEg==
Received: from [192.168.1.124] (31-10-158-205.cgn.dynamic.upc.ch [31.10.158.205])
	by dd3514.kasserver.com (Postfix) with ESMTPA id 408091023B6;
	Sat, 12 Oct 2024 23:14:35 +0200 (CEST)
Message-ID: <654edb82-759e-4845-8698-5257fe69a27c@walterzollerpiano.com>
Date: Sat, 12 Oct 2024 23:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Character device abstractions for Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
 <2024101256-amplifier-joylessly-6ca9@gregkh>
Content-Language: en-US
From: Josef Zoller <josef@walterzollerpiano.com>
In-Reply-To: <2024101256-amplifier-joylessly-6ca9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +



On 12.10.24 09:29, Greg Kroah-Hartman wrote:
> On Fri, Oct 11, 2024 at 08:55:41PM +0200, Josef Zoller wrote:
>> Writing character devices is a common way to start writing kernel code,
>> especially because of the book "Linux Device Drivers", which is still
>> one of the best resources to learn about Linux kernel programming. To
>> allow an easier entry into Rust kernel programming specifically, this
>> series adds abstractions for these kinds of devices to the Rust API.
>
> I understand this, but if at all possible, I would prefer that people
> stick to using the misc char device interface instead.  It's much
> simpler and integrates better into the overall system (handles sysfs for
> you automatically, etc.)
>
> I've already merged the misc device rust bindings into my tree, so why
> not just stick with them?

Aaaah, I should probably have done some proper 'market research' before
just blindly diving into and implementing this. So, if I understand you
correctly, you're saying that only very niche use cases would benefit
from being implemented as a raw char device, and that the misc device
interface is the way to go for most cases?

>> I also included a sample that demonstrates how to use these abstractions
>> to create the simplest example from LDD3, the "scull" device.
>
> This is great, but why not just provide the scull example using misc
> device?

I don't remember seeing a misc device implementation in the book. Are
you just saying that the scull device could be easily implemented as a
misc device instead, or am I missing something?

>> I'm also aware of the patch series about misc devices that was sent
>> recently. I think these are both valuable additions to the Rust API, and
>> could even be combined in some way, in which case the file operations
>> abstractions in both series should probably be separated and
>> generalized. But I'm still sending this series as it is, because it is
>> my first ever patch and I could use some feedback on my approach.
>
> That's great, but I'd prefer to stick with the misc code for now until
> someone really really really proves that they want a "raw" char
> interface.

Fair enough. So, it seems like I should probably just drop this series,
right? I will probably still address the other feedback you gave me in
a second version, but putting much more effort into this series seems
like a waste of time now.

Anyway, thanks for the honest and early feedback! I could have easily
spent much more time on this series without knowing that it's not what
you're looking for.

Cheers,
Josef


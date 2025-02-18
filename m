Return-Path: <linux-kernel+bounces-519668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A61A3A065
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAC1887646
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FD26A0D2;
	Tue, 18 Feb 2025 14:46:36 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4F161310
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889995; cv=none; b=T0Dcxr+OacdD4oFsYzsa3+UKyTDw1nQzhkAhQlEnan8HxOJsnJQuq9zfpRPq1MPu4si7IDNrObUQbgU4RDB7sCkgWGcHI/yPU6Xbz1MaVKjk40gzoU0LO/VkEOl/D5ffjs5M8dKtEmLyD79lBydz+unmLzM1aHWRToRS4cIkYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889995; c=relaxed/simple;
	bh=vzaGpdLNX9OLuU+R9yufw9PuZi+mKKQ3x8jQJ0RfnxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzyXuJf5BQiRwphkPG8lhGVc5TM+Zk+GaeDe39ThJ8xfFq9LSm4Klh/AdQD5LkVFKLknVyaQgiEcKJiTy5MUGJWQlfT1CAgXawTK4IfdI7xMxtBstCtoJ74Rd6H9vNf0NM9bBLGHCXsRfFxJDcKOXfLF7f3cfA4kdJVBEFFnADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB4C844196;
	Tue, 18 Feb 2025 14:46:23 +0000 (UTC)
Message-ID: <52e0c3d1-239b-475e-8ddd-932a460c6da1@ghiti.fr>
Date: Tue, 18 Feb 2025 15:46:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is
 never less than zero.
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Philip Li <philip.li@intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-riscv@lists.infradead.org
References: <202502171326.j4Xd3I0j-lkp@intel.com>
 <20250217092445.GA29568@lst.de>
 <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
 <20250217131203.2657cc4b@pumpkin> <Z7PWuSA4jtZnxp5J@rli9-mobl>
 <78ff844a-0fb4-42f6-b54f-4d19e14cfd05@stanley.mountain>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <78ff844a-0fb4-42f6-b54f-4d19e14cfd05@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefffedvleetleetjefhjeehudejteetvedtvddvtdfhieetffelvdffgefgieeinecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeduleefrdeffedrheejrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrfeefrdehjedrudelledphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhhihhlihhprdhlihesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepohgvq
 dhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghmsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Dan,

On 18/02/2025 15:21, Dan Carpenter wrote:
> On Tue, Feb 18, 2025 at 08:39:21AM +0800, Philip Li wrote:
>> + Dan
>>
>> Hi Dan,
>>
>> On Mon, Feb 17, 2025 at 01:12:03PM +0000, David Laight wrote:
>>> On Mon, 17 Feb 2025 13:06:49 +0100
>>> Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>
>>>> Hi Christoph,
>>>>
>>>> On 17/02/2025 10:24, Christoph Hellwig wrote:
>>>>> On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote:
>>>>>> New smatch warnings:
>>>>>> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.
>>>>> Looks like this is an issue in the riscv virt_to_page implementation
>>>>> which also shows up in various other places.  Any chance this could get
>>>>> fixed in the riscv code?
>>>>
>>>> To me, the only test that could give rise to this warning is the last
>>>> part of:
>>>>
>>>> #define is_linear_mapping(x) \
>>>>           ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) <
>>>> PAGE_OFFSET + KERN_VIRT_SIZE))
>>>>
>>>> But given that the config is a 32-bit config, it should not be evaluated
>>>> at all.
>>>>
>>>> Could that be a false-positive and then an issue in smatch?
>>> Why is smatch even looking.
>>> The equivalent check in gcc has been moved to -W2 because of all false positives.
> The Smatch check is a bit more sophisticated than the GCC check...
> I think if you removed the (!IS_ENABLED(CONFIG_64BIT) condition then
> Smatch wouldn't trigger a warning here.  How would I duplicate this
> warning?  The "ARCH=riscv make.cross" command does a 64bit build.


riscv uses the same toolchain for both 32 and 64-bit, if you look at the 
faulty config, you can see that CONFIG_32BIT is enabled so it actually 
is a 32-bit build.

Thanks for jumping in,

Alex


>
> Screw it, I can just silence this warning based on that it's a kernel
> build and the variable is called "_x".
>
> regards,
> dan carpenter
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


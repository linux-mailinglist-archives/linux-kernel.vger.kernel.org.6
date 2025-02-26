Return-Path: <linux-kernel+bounces-533444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33531A45A80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D25E7A7B85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC1238152;
	Wed, 26 Feb 2025 09:44:16 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8017258CE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563055; cv=none; b=dsZ4xfXL4NL28bFVW5rJ5Vy4SIge0uyS4JUbhlLkfDPBidKl95zBPTO6PNm+z/t0ZN8h7p657C+3ZZbLUYTfJ0rBoaULse4LY8cwDt2hfSJlOTpYYo0YH26kjnbGX+/62UnkgG/M2FUUDrWpIuvwheWj+OyJoeQ2CUX3VgfzXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563055; c=relaxed/simple;
	bh=5OvhCwfD/H/3h0RdnpDS9+ANym7YlxnxYKqwO+KyK4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edBrvioUu/7MCupS8HhskLmPkcDae3fK29pg3CH8eUCPoub98D37rzfIo6wN731Ql1+7JNUfUdAApSpCOBlVbd8kBRiWDie0GAXDNYMVEJVX7WieoKM2YaJK09Rif4xLohS3/phWxnP/LFt1rPbYWK625J+ve5437On4KpnKuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13FAE44118;
	Wed, 26 Feb 2025 09:44:08 +0000 (UTC)
Message-ID: <714de417-e354-4157-84fe-22ecd9c5e4c9@ghiti.fr>
Date: Wed, 26 Feb 2025 10:44:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Move vendor errata definitions into
 vendorid_list.h
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>
Cc: conor@kernel.org, alexghiti@rivosinc.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com,
 leobras@redhat.com, corbet@lwn.net, peterlin@andestech.com,
 Guo Ren <guoren@linux.alibaba.com>
References: <20241214143039.4139398-1-guoren@kernel.org>
 <20241214143039.4139398-2-guoren@kernel.org> <Z4q9MDsywT5MrlEa@ghost>
 <CAJF2gTQzvPey8pqsnZ+A2xvNFmb054wdp3+cgnq_p=eq+REBbg@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTQzvPey8pqsnZ+A2xvNFmb054wdp3+cgnq_p=eq+REBbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrl
 hgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 18/01/2025 04:46, Guo Ren wrote:
> On Sat, Jan 18, 2025 at 4:27 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
>> On Sat, Dec 14, 2024 at 09:30:38AM -0500, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> Move vendor errata definitions into vendorid_list and make it re-useable
>>> for other header files.
>> Why can't errata_list.h be included wherever the errata definitions are
>> needed?
> errata_list.h can't be included in rwonce.h.


vendorid_list.h does not seem appropriate, I think the best solution 
would be to fix the header issue and if not simply possible, introduce a 
new header.

Thanks,

Alex


>
>> - Charlie
>>
>


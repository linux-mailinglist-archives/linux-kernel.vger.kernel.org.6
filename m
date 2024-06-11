Return-Path: <linux-kernel+bounces-209709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8A89039BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C21C23153
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDFF17997D;
	Tue, 11 Jun 2024 11:11:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C417B411;
	Tue, 11 Jun 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104296; cv=none; b=HBHMM4LGetG3M5zSaXd1NAPcHxtHipoRIbzZDZLHB6QTe7UlzRgWxD8nRrNV6CSCRDOpFoKfRx/HAE8ara2Czs0qh5yiSo6fPdXOC1W+VxPwRdwFwCp0GvfAZNzASN++xwwDavwAy+H8h5bBKQflikj5hnxv6Dln1+PVOEKRhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104296; c=relaxed/simple;
	bh=uRZY5++FD2Fuc5LmfxwAK2s0CFsWxxeeRmiTsm6NsmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+M915/R0RXR/R5GgHcd5dzqIsCXfzM668jZQ0SWdeS4dm8E43+E7x0WQ/C7jjhz5FAMCTHxuTjwBlb3OpBGl0GYDn22FBdrZroJkEJT1v7R3qA+KZ5jfcPh/4vgBeZvdAaCkiCle+ME4VtsAQR8trzSyzzxDUn++/iUwu7mmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.86])
	by gateway (Coremail) with SMTP id _____8AxHuviMGhmEaQFAA--.23038S3;
	Tue, 11 Jun 2024 19:11:30 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.86])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXcffMGhmKO4bAA--.3660S3;
	Tue, 11 Jun 2024 19:11:28 +0800 (CST)
Message-ID: <3931f2be-fe98-45ac-8a40-a474dd7ef61c@loongson.cn>
Date: Tue, 11 Jun 2024 19:11:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: add process/researcher-guidelines Chinese
 translation
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611042515.61387-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240611042515.61387-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXcffMGhmKO4bAA--.3660S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

Hi all,

在 2024/6/11 12:25, Dongliang Mu 写道:
> Finish the translation of researcher-guidelines and add it to the
> index file.

How about add a tag?  just like:

Commit xxxxxxxxxxxx ("xxxxxxxx").

This will reduce the effort of subsequent document updates.

At the same time, I also noticed that Ziqiu sent an automated probe
tool, and I think this will be useful for running scripts in the future.
What do you think?

See <https://lore.kernel.org/linux-doc/20240422065822.1441611-1-chengziqiu@hust.edu.cn/>

Thanks,
Yanteng




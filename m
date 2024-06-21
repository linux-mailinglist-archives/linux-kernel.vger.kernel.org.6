Return-Path: <linux-kernel+bounces-223764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A89117E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5CF1F22352
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289CB65F;
	Fri, 21 Jun 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiNidqsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B588C1E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932384; cv=none; b=XY+LAP44hwyjm02L0Wgo5umddbkqD5ya65FDtwdME98b4HxG+rJt90GQERz0bUTOw/6fgmKje4Rs9EiR81iplbOVQlHvQUmpdk4vRS9zGFeQtxCacWEktgRTjEWCk4GhiLVoQKNcxZby6RuHvuqq0wf35tcRHrOY4k6vBSIci38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932384; c=relaxed/simple;
	bh=AD7WJckCW+gFPM5oD8pJlx7SFP0QNTxFauNINICT8Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LieQv+ow1DfODCSAVx+gd9M6X4xxENiWYZTuuRm6Q/qo3jrus+HlAS0M1ErtR3H/rfY06fNAxUE+AhryXQ/qQwMkMVwqHk9ziiIIRrLSAK9Ikvkjn85LjLpzyxyX+qphGCaXwyb45Qn+wlurnQtCKbXQr9LG8ZIKlAsZ/KBIIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiNidqsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F3C2BD10;
	Fri, 21 Jun 2024 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718932384;
	bh=AD7WJckCW+gFPM5oD8pJlx7SFP0QNTxFauNINICT8Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiNidqsPs41kyA920se/KlL64A6K2dPkPCDY3p44xFPFWWt1GqtMMiLhxAJssjPcR
	 TnQglyrmFo6nonLmcydJNZ/w2DND+HH6Bv2sIKxJbYgvQkyJYLQLkvHIlAD2/eQ7L8
	 Opf22CtSTls/fCbWMWwj2TtJNZSUhba8DEfx6IamsBr55UpkPf7Q9w4waQAoHPk/So
	 chtxEAdncKWduFMEdL9oZ/RUHFSN0KPQ69HdxWCqNbum9PF1ojIN5rRvr1ai14A9r/
	 gDgegbPERGAuNcPtBQbXoUrTgudeVu+EeYREzofPS+xzCZ5gML6iQ5qVeE9eurYLFI
	 zftksB/Eznmmg==
From: SeongJae Park <sj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	amazon-linux-kernel@amazon.com,
	linux-kernel@vger.kernel.org,
	lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.1.94
Date: Thu, 20 Jun 2024 18:13:01 -0700
Message-Id: <20240621011301.69542-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024061613-stoneware-kite-ee9e@gregkh>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello stable kernels maintainers,

I’m sending this test results report on behalf of Amazon Linux Kernel team.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sun, 16 Jun 2024 14:04:13 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> I'm announcing the release of the 6.1.94 kernel.
> 
> All users of the 6.1 kernel series must upgrade.
> 
> The updated 6.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

Amazon Linux Kernel team tested this kernel with their downstream patches on
their internal tests setup covering multiple x86_64 and arm64 based AWS
instances, and confirmed it shows no regression compared to its previous
kernel[1], which was based on v6.1.92.  The assembled tree for the tested kernel
is available at our github repo[2].

[1] https://github.com/amazonlinux/linux/tree/kernel-6.1.92-99.174.amzn2023
[2] https://github.com/amazonlinux/linux/tree/kernel-6.1.94-99.176.amzn2023


Thanks,
Amazon Linux Kernel team

[...]


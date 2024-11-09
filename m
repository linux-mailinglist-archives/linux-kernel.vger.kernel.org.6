Return-Path: <linux-kernel+bounces-402600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5179C2987
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D3C1C212E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC53C488;
	Sat,  9 Nov 2024 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB9z4exY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C528379
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120050; cv=none; b=cxyGYQDTGnR7gLwDiijF7+g18jgBdHDAXdqgHwzeqBep0FNYrR+/23fqyzHck7R+wcw1zaZU7rpnSh/7m0PgiHlW4th4/ioY5zO4rRJLghScSNZh7N3xmTIcWAPUpGF0TcgAh6MAsP+Nlni+BafuWfof69NvValgZEV0QpS1Kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120050; c=relaxed/simple;
	bh=+GhGWU2CHZTI3TzF/vO1QWR4gbfFD3OS4VYE6Jxqzfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJCoNBRJFJ6DrUsRKXR0asQJ4pncD/oPd4fKiBTpx5amYmfIMXgJSTb72VFaVRewIIIt1qaTDgnelWz6hTm3Gb9EOqHoIf/LDa26Wrv9JMijKWMbIEwYSWDFv+6X8aVP0BuyiemVJEcUEKAioOJsXnwLU20YE624ZXNofb1VMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB9z4exY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0DDC4CECD;
	Sat,  9 Nov 2024 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731120050;
	bh=+GhGWU2CHZTI3TzF/vO1QWR4gbfFD3OS4VYE6Jxqzfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZB9z4exY6y0ld9kDT15BK6mpp3XgTXUlsnbQteu6EnIsNupJGTQVcIIUIfy8hd3rf
	 jKGMPLResdrpDQFGFO+8b8U3gxUoi1c6ahc3rjB9DGW8J7FSaAiyuNRLtSr3kbul4T
	 B57/fNuFrmJ+7wNK2yMKQpjuNVfXV//yGHDc8uLewf2t1ECQRhwC/ANfMJsD57TmmR
	 WkeuyO+6CS0NLrJ+2WoHlPjw7UtgginrZXkuEZq6R3eESDMnE70sndRhjs4Ut0wrld
	 erZz0+tBhVtRI8f0BedINsDyG5yAECO+AM+Hwh5Q3E90SycKp3birXk1uw51BZIMBr
	 lkxG6P5q1vkLQ==
Date: Fri, 8 Nov 2024 16:40:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Clarify sched_ext_ops table for userland
 scheduler
Message-ID: <Zy7LsZlZQiF9HWoh@slm.duckdns.org>
References: <20241109022514.173631-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109022514.173631-1-changwoo@igalia.com>

On Sat, Nov 09, 2024 at 11:25:14AM +0900, Changwoo Min wrote:
> Update the comments in sched_ext_ops to clarify this table is for
> a BPF scheduler and a userland scheduler should also rely on the
> sched_ext_ops table through the BPF scheduler.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun


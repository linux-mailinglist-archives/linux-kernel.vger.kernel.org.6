Return-Path: <linux-kernel+bounces-197477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA288D6B28
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030B21F21965
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DEA77111;
	Fri, 31 May 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO3fy8fg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B7168DA;
	Fri, 31 May 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189477; cv=none; b=T9pHlp69E1fBMRlVOWuZVO25gUJFFTlnIw7Xaqn4t+hAjHWviEokWfTcuI64yUjCUZ9NFeFGci/aMg4e9UkHJqMt+bt/rhBUbcC7RlMLmUaASDMoY9EdVsqScXNFhZTE3rzjQ9VaUkw56gsZnCs426127CRb30JH1Zt8o7EmoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189477; c=relaxed/simple;
	bh=nlf2Py+keWPZWb2WEcXyuXnPsjey2AglcXUUfxlnR8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODmlVKDgNFJL5ty+d5IugHTyuHkDFg2mTAHkceq4EwGJ5RV6jKhMoqdbaprFth3PDsbKUs6JE2M6lpW27hD4hKKzldaiBfGi1Bms3bSbi3Mfv//4Ko6iEkOQW4RGuMsXNOIa9XOu4NE880Esa1SQpfLe9/vKf+cdSaMmYgmoC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO3fy8fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EC0C116B1;
	Fri, 31 May 2024 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189477;
	bh=nlf2Py+keWPZWb2WEcXyuXnPsjey2AglcXUUfxlnR8I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nO3fy8fgQWn0NjyZ8qCpS1EbBXel6/8sp/s2m7QTRhjbVh2L3lh6BQqV45wV0NGnQ
	 NUwO6NMl/83GNmFtwZDl0TiF+pVcT2VyYqFsyk9kMFWk/W/ISrDPvrB8RD6sGLjahn
	 5oOjXG8qKT8D22/7KKNuSnCz2ZrXTbDQR1Tv1hTRCBOP1eTTvM34WkgbyR0wVTJhHB
	 5OQkpTBLSl50CWfoRhIKhdvZF75NVtqTdJ5zGmF5yGdi5LaVmsGi8aoYAqzKtTZFke
	 tGTVzBp3iSiWKeQYHauYzewx9ClsPafPWCpyPBPjK2SBhSFO6Y/Llgd1SM+HkChLXL
	 k68EsIKPxl5mQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2E67CE1347; Fri, 31 May 2024 14:04:36 -0700 (PDT)
Date: Fri, 31 May 2024 14:04:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: add missing MODULE_DESCRIPTION() macro
Message-ID: <2fae7fe7-1e4f-467a-b03d-3fcd6025d144@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240530-md-kernel-kcsan-v1-1-a6f69570fdf6@quicinc.com>
 <CANpmjNN1qf=uUnetER3CPZ9d5DSU_S5n-4dka3mDKgV-Jq0Jgw@mail.gmail.com>
 <e9b4a22f-1842-4c37-8248-4f715d70a6c1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b4a22f-1842-4c37-8248-4f715d70a6c1@quicinc.com>

On Fri, May 31, 2024 at 06:54:03AM -0700, Jeff Johnson wrote:
> On 5/31/2024 12:47 AM, Marco Elver wrote:
> > On Thu, 30 May 2024 at 21:39, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> >>
> >> Fix the warning reported by 'make C=1 W=1':
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/kcsan/kcsan_test.o
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > 
> > Reviewed-by: Marco Elver <elver@google.com>
> > 
> > Jeff, do you have a tree to take this through?
> > If not - Paul, could this go through your tree again?
> 
> I don't currently have a tree. Kalle is in the process of relocating the
> wireless ath tree so that I can push, but that is still work in progress.

Queued and pushed with Marco's Reviewed-by, thank you both!

							Thanx, Paul


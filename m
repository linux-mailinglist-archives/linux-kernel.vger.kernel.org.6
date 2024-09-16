Return-Path: <linux-kernel+bounces-330297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC004979C42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6D1C22521
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2C13B2A5;
	Mon, 16 Sep 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKFdAhXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979311339B1;
	Mon, 16 Sep 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473010; cv=none; b=GdGocc7jnKRChtJqhSM6CKT4hqvouVvO8JYNMewdxegwJ81+rV2Dj+vHBFCWPq5J68h6FCmjVQqEjNiWhdrk3wrCHN0w4OAHMlZbsCKxuwT8EvD7YHvIhoVCqpT3d5ufgj+0R0OcwCtH5hKoJCRqh20M251kr7ZWJHqyGA09lVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473010; c=relaxed/simple;
	bh=oV/rO+rIUTVYa4h0wxcp7MAVCpDJMSEAlgybJBzpQHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSLcGWsJUwLDvcM8m2pSjJD8DV078ghUhpMFUjYhu9+qqTvPg8U0oJeA+MBoWQ8xGuqBNn0OJP6rxYfwvfPP3z2XHp1wYQkh1NTe3e9afjSkXYubACsW0VSOeV+kGmtFEHRJNuq812KSTkNyqPQG6dzi5SaEegXkvb8FbX38H2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKFdAhXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F9C4CEC4;
	Mon, 16 Sep 2024 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726473010;
	bh=oV/rO+rIUTVYa4h0wxcp7MAVCpDJMSEAlgybJBzpQHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKFdAhXtphS6fWKaRpjmKRfIr+/wtF+QpBjwKMhu7sLPhNH1T/XgS1DKvbNBRJ/F0
	 g/qrrq44VJddTKMJwZNsuCOaXxog2Hnwogh7AWke2ksY/ZRauBpzNnXzAiq0G4Ipm0
	 eKXF0ao8cRuNRAjLYhulPGN/sv9mJFAFKdE0HCmne15j1cdu7t7kBRRHxDZ92wQm6M
	 81acSv9trf3cLFTCIobGyxm52YXOZrU/7e9BvGQBbcwMgp5SGBGz0GdED/urEm3qz2
	 aAzbdgK12il101jbRmBCb0xJfqpUcULWdl62De1fpCkkyeZ8Qt83Gb8wSdmRDkFbSe
	 9R6Ni5xz99bbw==
Date: Mon, 16 Sep 2024 09:50:08 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <ZufjMLwX4m3ECJoS@vaman>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
 <f4c222e2-cf94-44ec-bc69-0ab758bfb3fa@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c222e2-cf94-44ec-bc69-0ab758bfb3fa@leemhuis.info>

On 11-09-24, 16:31, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.09.24 14:31, Greg KH wrote:
> > On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> >>> The reverted patch causes major regression on soundwire causing all audio
> >>> to fail.
> >>> Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.
> > 
> > Really?  Commit ab8d66d132bc ("soundwire: stream: fix programming slave
> > ports for non-continous port maps") is in Linus's tree, why isn't it
> > being reverted there first?
> 
> FWIW, the revert should land in mainline tomorrow afaics:
> https://lore.kernel.org/all/ZuFcBcJztAgicjNt@vaman/
> 
> BTW, in case anyone cares: I think this is another report about the
> problem, this time with 6.6.y:
> https://bugzilla.kernel.org/show_bug.cgi?id=219256

Revert has been applied to 6.6 and other stable kernel so this should be
fixed now

-- 
~Vinod


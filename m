Return-Path: <linux-kernel+bounces-326363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E19976733
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDB1C22FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2D51A0BE9;
	Thu, 12 Sep 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWu9BMRM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899E18E043;
	Thu, 12 Sep 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139408; cv=none; b=gY08smx/6EKkmtVJ0I3SZDQm2RwyrRScS1lyrfC+vHAIebek3rotkriEOkdq3wWohma3R0r3XYrlKnyhhknDEO0iaect54YEigcxdj1MfsbCNME98Rpqzy4FSKsdS8P/OFVpTmQro3ET2X4iB3KpuNcygu3kWMAL/qO1N7j0zNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139408; c=relaxed/simple;
	bh=oy3t622oJ9y+zBSmV8Hg+lcYB3qkvoxDjsisvYrdppE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Uz9artYbDn1ay0Cq7WOSd5aLn+DswXfYdwrAp3VCSaGS9Uladi1DgY3MQCk4GB7r1MucWKbj8OdoB2ebsR1f/HpwjF9N9KbO/4nx1Ha3wep/o0OzE61YRwDzjeXQSGkvTMnpDE96mM4kcrAVWmM8EqGYATAPphuE222Oegohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWu9BMRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B658CC4CEC3;
	Thu, 12 Sep 2024 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139407;
	bh=oy3t622oJ9y+zBSmV8Hg+lcYB3qkvoxDjsisvYrdppE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWu9BMRMIZdrUo2PalQuBsGnB+9JnFSU/DqQw6d9z+BjowPoVlwKvlQ/25LdoOXk5
	 BudvONRc8oDogUUf7qK/Nk7tPlMY37qPhxWo/eru6X+51QDh8TE8xRJMALvetLfNVo
	 gVfmVmelDJTNGhk0ABnRWNodtoIeYLJ8mDYSvwWKJnh6ktNRc1HKV1HBFeohpSUzgS
	 zzZMvGikWzmqOJm8A6Kh6gA1lX0PCu5uo/WykBE1L4AbUGwuSJH7pDbua1Vo08ct93
	 2CR1zhYTkytu/6Yf69DUnQcsN8uYSWp3/TUVLmezR7ybPK2agEXYgzp690DtURzEW1
	 bgvBWt9n5+fdA==
Date: Thu, 12 Sep 2024 12:10:03 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v2] Documentation: networking: Fix missing PSE
 documentation and grammar issues
Message-ID: <20240912111003.GI572255@kernel.org>
References: <20240912090550.743174-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912090550.743174-1-kory.maincent@bootlin.com>

On Thu, Sep 12, 2024 at 11:05:50AM +0200, Kory Maincent wrote:
> Fix a missing end of phrase in the documentation. It describes the
> ETHTOOL_A_C33_PSE_ACTUAL_PW attribute, which was not fully explained.
> 
> Also, fix grammar issues by using simple present tense instead of
> present continuous.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Add grammar issue fixes.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


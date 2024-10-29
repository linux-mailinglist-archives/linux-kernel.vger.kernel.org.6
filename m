Return-Path: <linux-kernel+bounces-387172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C959B4D06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24DB1F23D04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A596192D6C;
	Tue, 29 Oct 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2XlIfYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C46191F67;
	Tue, 29 Oct 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214486; cv=none; b=YaF0RZ5LVxkL63bhBlRqBkdvDhOknHc07qSdgYCKnMkPFpogLaBmBhvDFi1I0VJRkIkryjNAdMCQzy+Vsy4UigxZGV1PviU/f0OsHL5NuUJLZaYhU2T3IUNM2LQY1dG5Nkkv0CadxZ6VeYVy3jIML/I1+iMHPrzIL6I0Fp5x98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214486; c=relaxed/simple;
	bh=iGOER0t4cHWXo7gmzOPpqJZ4M5x6K6nHCQw7ZS8nIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYICVo0yi3XADKEQNhGnV3LxMoEXaXBjeXxZJE1UG1X6gDlR80N7NEWbnGj6r6Z75rXbBVV3lzQZ4noJ7kgbj5yHKUzJSXQZ8R+jETZVmaj25NdEikWM9gETKu3BlbRYu87sLLS9foI6CcmxNCeS3JRt99VWsgjJ0e8M3KS9zkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2XlIfYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB55C4CECD;
	Tue, 29 Oct 2024 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214486;
	bh=iGOER0t4cHWXo7gmzOPpqJZ4M5x6K6nHCQw7ZS8nIXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2XlIfYrTYXMF+6N5jmgdFApv15P7dNB7Sxi8CkHtgql+3TaOeuWe4d00VEyzaiwx
	 a54GHby/i7YrejwQJ/VdfofVHO+V4xBs6k2rfS4IDhU9tRU6QUdxkWeJUxtX8b0VxE
	 mduZmfdSBAkdGGigKS+sCiCMXdD/w6kAeof1t6pYMKEJSEGAoY9NnxCOXnoQNLFS/Z
	 mrCYOzaGaIjIyqodRaZzIblCpv3bt1bc/bBHqMGNK4Hc4pOpaXrg57CEZULoO4Txdx
	 rml+5keRHYOplWtF2mUjvlPyAlgMdAlJ/s/pTrO2AEvh8MCuHRJqXXF7SJHxrfk90L
	 IjenQdtHK5Z9w==
Date: Tue, 29 Oct 2024 08:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Simon Horman <horms@kernel.org>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v2] Documentation: networking: Add missing
 PHY_GET command in the message list
Message-ID: <20241029080804.7903239f@kernel.org>
In-Reply-To: <20241028132351.75922-1-kory.maincent@bootlin.com>
References: <20241028132351.75922-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:23:51 +0100 Kory Maincent wrote:
> ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> Add it to the ethool netlink documentation.

FTR ETHTOOL_MSG_PHY_NTF is not present in any _released_ kernel, AFAICT.
So we could still delete it in net before 6.12 is cut.
But if there is a plan to use it soon we can as well leave it be.


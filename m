Return-Path: <linux-kernel+bounces-305806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D669634B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF4E2831A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF41AD40D;
	Wed, 28 Aug 2024 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7O6bhAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158C165F16
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884169; cv=none; b=VZBjSOdm6ne1GB8SJsyS0SJW84Wq9CnRofCCx8ZAD5L+1GCtlQNlzc+68ScDy+9e10nUjoE2q9lyMvkT9BrSj8Anb0mTbByuwoGJgMfgTlKCy0nuu5d1SBAiH8gq1LaKe81tgQxDu3Zgc1y6q9T9b7lbi8lWUT+5toLGzhG9bUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884169; c=relaxed/simple;
	bh=8NyVVknwOoJV4y3UmjV2R1rxmk6WPYDWG9V81qniLqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg/5Vi0Pb+bR3XChSXZaZc+7IILab9q1lXscaKXuH0Fn7VRx4BdjG3Ew9rLXN++ALvE3/tvDcUPS585Ht7w2PP8RzIt/Buir1BZZ5x5lYs5N6tnO4eo0t6aLNS5aMgtUvgAZhAOJ+XmH1CLijGFCoMAH4En6+BlXaf7hUsBmmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7O6bhAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3F5C4CEC0;
	Wed, 28 Aug 2024 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724884169;
	bh=8NyVVknwOoJV4y3UmjV2R1rxmk6WPYDWG9V81qniLqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7O6bhAKMP7Tk40U5Fcei/0ppHJAsV3KgSYntXA1s2lhaxYcwa06fGw/KjwUhtai4
	 upxyTtiUPomm29Ij3OXqCHS8eqdkjBkwv4F5RFJ27zHIwxfVEjDD//0QVzrGFRgAHZ
	 +Ql7rqnghmpCeJGwwgW7jDK/2dEstp005gFqvtAgCRdg/SBrVyrrRfD1xVLdnzlA2Q
	 RYNCS0BOHGkf5Lx0eBQv6Bzg3gEQUaVEqfi1VrwMOF+xyDNP/RMJlb4XLErTxT4sN6
	 VdcEE8ZdXfgNV/KvyHx/tvGaaEPB2Tb6QQfz150P8ZfiW2eXgKjieeAFHApREO3bf3
	 GgCfUpHwoc35w==
Date: Wed, 28 Aug 2024 15:29:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, p.zabel@pengutronix.de
Subject: Re: [PATCH net-next] net: ag71xx: update FIFO bits and descriptions
Message-ID: <20240828152927.6370bed2@kernel.org>
In-Reply-To: <20240828204251.6642-1-rosenp@gmail.com>
References: <20240828204251.6642-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 13:42:49 -0700 Rosen Penev wrote:
> Taken from QCA SDK. No functional difference as same bits get applied.

Are these used? Would be nice to heave your best guess on the impact
this change will have in the commit message, for posterity scanning
git logs a few months/years from now.

BTW missing CC netdev, feel free to resend without 24h wait.


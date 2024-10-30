Return-Path: <linux-kernel+bounces-389751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB09B70C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDEBB2115B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1E217657;
	Wed, 30 Oct 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk4PbcjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4C1BD9E5;
	Wed, 30 Oct 2024 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332326; cv=none; b=dX6xfEbJ26r+fEcoYATZ1eCmTsjuCP/JO2mNlFq6BFMo+b1KkjB4cpG7p3Kasdm6COREE9LCtbS4ETtCmi4c3Z8Yv9JeBDzlzTzHtgc9lr6Vw/Pfi5AskInZXnU6UZHE0TrsuKjf0c7/MxO+Ox0lukbXIpJp0JHwpCbUOyULm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332326; c=relaxed/simple;
	bh=IdOAZHG4PPixFzJ5QFNgx3YlGP74kTM3xXO1m2zmioE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Szk3iMewju7o4FTSrAs6WlTem9L/cgeF/T6djKVQ18HX2lncJSUjDvXwM7hzjXOLXfiRP9LdvZd/nAbRcx25o3GO3DsZW8vcB2Hj3Z4JboHqJKljlQAzA1KDmoDVkeC1voKTJNrI2oMy6yQ4G0LC2We21GMd3jAo0xZPIsV0G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk4PbcjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80F2C4FDE4;
	Wed, 30 Oct 2024 23:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332326;
	bh=IdOAZHG4PPixFzJ5QFNgx3YlGP74kTM3xXO1m2zmioE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xk4PbcjESxuPxQuPB3bWsORo0GWKKzXkHvgJouM7TR8CexRc819q1yuNrY34saWdX
	 AVaqeidbnXkB5ZWX3I8ev6mmFJCkNusk9ShnCqaTSr0JxGGRuc85DzzYeUidz0d1of
	 w9J1IqbJ4/NIv3+XJbttX4g41XN7iQQnADhMIIgLfJigZscxGv3zzrjRsBSzeSvYRR
	 6ek5RlSeDMDch/8HLh5OinwTyjKhJFSl3TmxwchkKJVePNCoVlm06JQ2Iqp43VoBqa
	 B+1YCv+7cL9Od4XiHntkwzcAEuuZXmxUz8R1majTmYRD9D+KCWKOOu5zkTQAikBSl3
	 UrFlBDewBK18g==
Date: Wed, 30 Oct 2024 16:52:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv2 net-next] net: mellanox: use ethtool string helpers
Message-ID: <20241030165204.1c803b60@kernel.org>
In-Reply-To: <20241030205824.9061-1-rosenp@gmail.com>
References: <20241030205824.9061-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 13:58:24 -0700 Rosen Penev wrote:
> These are the preferred way to copy ethtool strings.
> 
> Avoids incrementing pointers all over the place.

24h between postings, please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h


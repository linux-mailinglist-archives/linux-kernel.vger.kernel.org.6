Return-Path: <linux-kernel+bounces-227717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC729155D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C09C1C20B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078691A01B8;
	Mon, 24 Jun 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBJU53wA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6C19F47C;
	Mon, 24 Jun 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251385; cv=none; b=SigehmQ/Rvo/UO8Qa/syo2AF3IlpX5lqIT2nE+O3kXDlXnyq+KuUHZ0pSePDINozf/cwJoZ4V28ipAj1RHtXcmtl+FM0shY8VEDewFd8giMUlEPdu6uHgneTDhqUUpU6xG24yOvqbFfHA1KNJIJVA+2Ka3pLusOWST3UD6q96rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251385; c=relaxed/simple;
	bh=fdcZmVQTvBKlzGtJB0rbs38IWJtKIbhwGdF0unBeKpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0+/judMB+dBVp1NlmR6nBZb/W/eZK41vhWir1pg5iu2yMTnLXrisJfRvujKrzCwyard5O7IHHlkLZE6Lvdpr+dFQd/ecD4FxDW3oQchk9f0ghe0ykKszqHyjfHbmeJvxK7Rnh+3A1hYExvXGzVHeHF5yd3EIpjo7JKZgjN/b00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBJU53wA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF63C32782;
	Mon, 24 Jun 2024 17:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251384;
	bh=fdcZmVQTvBKlzGtJB0rbs38IWJtKIbhwGdF0unBeKpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBJU53wAz4XP+wG1BOPEmkGio5xLvrfONcN/uG83NH2IJyp3y2sk7TN+kd6Pq88o0
	 SpWkIFQaAKJ1gxm0zIE5VFeAcZit5DHRxEsdSDCDSvmCQpZqIWM+b8+q4zomqPR5k6
	 B/eJC4RCG8wq059J9xD7nqJ73GSLocwM2tp6ctB+cXa324YuFvTWX3rxtU/lDAXzRJ
	 IDKqLIJrHDAi+jUq2KkNweYhGGgTF3pEpLxzGirbmGfDMrT+AkLNRwOXPC4HtE4QFk
	 vQqkgRO6MHCs7wkwW7QI1aFff9AIQFclHIdUcUXdn9UyMOFVBKhcF7K48l7UdXQJNa
	 sLQC9zGbbPZdQ==
Date: Mon, 24 Jun 2024 11:49:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	Jun Wu <jun.wu@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: cpus: Add new Cortex and Neoverse names
Message-ID: <171925138023.25546.16081189790238958204.robh@kernel.org>
References: <20240618160450.3168005-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618160450.3168005-1-andre.przywara@arm.com>


On Tue, 18 Jun 2024 17:04:50 +0100, Andre Przywara wrote:
> Add compatible strings for the Arm Cortex-A725 and Cortex-A925 CPUs, as
> well as new Neoverse cores: Arm Neoverse N3, Neoverse V2, Neoverse V3,
> and Neoverse V3AE.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks!



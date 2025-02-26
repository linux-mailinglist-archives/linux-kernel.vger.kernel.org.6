Return-Path: <linux-kernel+bounces-534331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A930A465B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA86816B310
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456F223313;
	Wed, 26 Feb 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwf2gzju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5221D5A8;
	Wed, 26 Feb 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584684; cv=none; b=KPCQj4BVDcgUxH9fHIpsVMV9j2rnjHngrEFsuqR1rw/W916J2tRcWDHmlRnHr6KCECK5poxktgFE+1oD/HZOBptqOpqbVIfROXItt/kYdnR4SDSBqU169efH/QFVnzOhqdSd1X+tuOc3xRdd6USfeYvO2JZvfrt8BNDbqT2Zq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584684; c=relaxed/simple;
	bh=VDSomwl6LzEXsr4LwgRvd++OnseNgFtQFF9SkT6kNt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxUPf8eZP5KEbqyR3Vy+5fldwXwnoKNlXESOTqrIm6oQuji8utZYcqEziod9k9l4A+o6lM2qdEmFc64aCWjmV35BiNifVlDjVqMzKZqdCMV61N4E6uJJZvBnykXkOujWRnGdT1jqDlGc9c5alyuiHTup1f8nN94luG33RQpv1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwf2gzju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77086C4CEE4;
	Wed, 26 Feb 2025 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584683;
	bh=VDSomwl6LzEXsr4LwgRvd++OnseNgFtQFF9SkT6kNt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qwf2gzjuhyX5kLyfs/3nK1bGOejn526NdZSpQSKHGdVdeSXCusUHJmcR/f1rXWosT
	 qxa9ekOZgGBgeGx+GzZ4t6eS2QvN3kKX2dseUf8vNZiQ01PJzF7AHxBj6XMj8VMy4o
	 kzOyfGhALTnNCCpfI6bYgaHWXHU78CY3nHpPHT4uPuDUqmuLc2Vok2TeAZNC6cC358
	 bcXBRrphtqMUbEOrphyUSfdf+efbooC+KConbTAtK3N9CV6AEHp2c6OB/yNJ5zZPLX
	 5I4AFe2CTIl5CcHfjmtJv2z1vXBgdHxH0EN05zMBE5J/EtafHgl6vMksVSVEhHpLnh
	 /71lJSbYWsDww==
Date: Wed, 26 Feb 2025 09:44:41 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: dt: submitting-patches: Document sending DTS
 patches
Message-ID: <20250226154441.GA2485697-robh@kernel.org>
References: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>

On Tue, Feb 25, 2025 at 07:48:21PM +0100, Krzysztof Kozlowski wrote:
> Document two rules already widely used and enforced by DT maintainers
> and SoC platform maintainers:
> 
> 1. DTS patches should be placed at the end of driver patchset to
>    indicate no dependencies of driver code on DTS.
> 
> 2. DTS patches should be applied via SoC platform maintainers, because
>    it is a driver-independent hardware description.  However some
>    driver maintainers are reluctant to pick up portions of patchsets and
>    prefer to take entire set at once.  For such cases, the DTS portion
>    should be split into separate patchset, so it will not end up in the
>    driver subsystem integration tree.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/submitting-patches.rst           | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

I've applied both patches.

Rob


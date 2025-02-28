Return-Path: <linux-kernel+bounces-537885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8DFA49218
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2258E16C15A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004431C726D;
	Fri, 28 Feb 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxlI25C8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9A276D12;
	Fri, 28 Feb 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727415; cv=none; b=N4eTiRYXkjR/6MIHFX1gQv4Met035LpDQPt2S+a33WdDWXy+pwHB5ZmRpgzI9BVcgVTz/JtgQKXCCQMItbIaqlD1siCV02ovCoW/eNwbl4qM4/VUE3XX7o8Rlj/Rc6WHrPPATUcOyI8G6HP/jV/UWHstAnxq/F+SZ5p+ABAvYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727415; c=relaxed/simple;
	bh=FySeXdrRimFrLVwqw1+E2oUqxSwEtboPGGyAWNpiM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx8gLYhcZE2elC3EfTmzOJJD8Oy15nKuVpGUxV2qJtv5NFwGW3zOioJqOZg15vZUj8kDixik0oL1jN9+ZleLm8Zzi3dFIpM12gue1TPLF1CJighXYUz5AqsXuavn/eBIRUvXjms5zaLkKf9xZEa9ejcqZZXW0OlBee/QfB2fVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxlI25C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61D1C4CEE4;
	Fri, 28 Feb 2025 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740727414;
	bh=FySeXdrRimFrLVwqw1+E2oUqxSwEtboPGGyAWNpiM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxlI25C8FPop0ydCWps70MR+y6z76vAm2/cmEbbvriw8jRoYW4nteDqzBhRlHvSW5
	 EjwliWi4pQJb9u08ilDAtoT0VjlGKJo3+pCCu4mUhO0eOr+k4T6cqrN+IEWA9uf7Du
	 A5rNn2+ixyLpGcVQYcFII68RThKSTEvPzPyp1J/9QjN+2fFAensv9Y8HUxMWPKzc6w
	 ce3/EGPnt9CT0VUF4/KCuO4cgtUln63CjgUctezHut7tNjEeAduuc9IPOjRLQTrs+L
	 k4CyYDl2cIoAXXEgkVYgZ4H76fIp9QhfkICdYTCIe3tqDJfLCW5Q6GSZBu2VDzJw6M
	 yYB7OMke3AnNA==
Date: Fri, 28 Feb 2025 08:23:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 4/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Message-ID: <20250228-spiked-spaniel-of-painting-c5e5bd@krzk-bin>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
 <20250227120619.1741431-5-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227120619.1741431-5-peter.chen@cixtech.com>

On Thu, Feb 27, 2025 at 08:06:17PM +0800, Peter Chen wrote:
> From: Fugang Duan <fugang.duan@cixtech.com>
> 
> Add ARCH_CIX for CIX SoC series support.
> 
> Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  arch/arm64/Kconfig.platforms | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



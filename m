Return-Path: <linux-kernel+bounces-565766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A187A66ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1856F7A054D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1988205ABB;
	Tue, 18 Mar 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc0mPIzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AD1E5210;
	Tue, 18 Mar 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287527; cv=none; b=ZVy+PwGaskIN2G2zOjRuKU/nJD7XjaIFaUFqNcOHydjW18cmOA2K8wXwViwejytChl84zAZ+R9hKOjcu13ELN1g7LAVNVCszF2j5a4TJL45nngx6eIac47TwmpB/2jqHkp26mk9z9dBef1ucJxhg5AxRcUlLNWcN+6js/sZOD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287527; c=relaxed/simple;
	bh=xvR4q+kDcK2eJhnkZQxu0f9mq7keqwXDtJByURfUMBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT+vzjEb82qXOEdldz+fD6w2kWRxxmtFvrq3BYEC+gXykNZjhuyuZSSfpeXhJax+QcBDNy+Ak54poriPAuCwj4g2s143zxznRfv+rU4zoEzfea3vUIfEGXVg7eYjkyhVqiRlc9nq3T4EXLkca3WhOoaBhDv5R32eEb31Q2I07YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc0mPIzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF98EC4CEDD;
	Tue, 18 Mar 2025 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742287526;
	bh=xvR4q+kDcK2eJhnkZQxu0f9mq7keqwXDtJByURfUMBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mc0mPIzZcbkoWsgw/Yh+D4VVUkWFdSfIvMFA5e41vglhGpICtIJrlOa7pKfMamn82
	 XhoREwnpMhbcRL1xtHnbrRA632XsL3fcsP8NH8p96idE1tpO0vNe71nx9Wd8Dr4RF/
	 e5FfFG/FimCyHiVF5WIv66uJmd10dlYXedjbxgYSiWLDsmP9kllvAixBNW/kaEPybl
	 N4kbNi0bxwazA1YbOLiyddk2PQQFDssYSSEeHBd2fkIkRvmUbrLzjPjzF6XhTAh0U5
	 jlBP5uEawrXWuILN1fsoDS11F00d8zlB26UoKszf5zwXx40Pj+h7YPX4/KZiGEQI4c
	 6Pi1Pnz7UV9Rw==
Date: Tue, 18 Mar 2025 09:45:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Subject: Re: [PATCH v3 2/2] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Message-ID: <20250318-imaginary-peccary-of-argument-ab6b39@krzk-bin>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>

On Mon, Mar 17, 2025 at 11:12:24PM -0500, Rajaganesh Rathinasabapathi wrote:
> +/ {
> +	model = "AMD Onyx BMC";
> +	compatible = "amd,onyx-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = serial4:115200n8;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +};

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof



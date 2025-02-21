Return-Path: <linux-kernel+bounces-526792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582BA4035C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EC04407B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0A205E0C;
	Fri, 21 Feb 2025 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHmFM9jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F51F9F70;
	Fri, 21 Feb 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179610; cv=none; b=oRcgrfQ7W80vAzI64DZw71aVYiXM6JDMwhKdskkl2GR5Cb3lzHtRlM6AFtOKBw6l5jizNLCS43reuc5kdLf0nexO6uxvse5W+VH9PcwhtPluB+M9D+gyPOhO2X02EVBkkia16DlHROXxIz4xZJ5mUU1gH5mahq7fPoF7nc7CmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179610; c=relaxed/simple;
	bh=WNL0sZKfmWiQDFD9PEb2OlcoZ6MH5kNFz9BDs90AdBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K06yygCyLkPBHR5tW+sGOVAk6CrzmaX9jHEKTqFr+lH1TgmQLQ0Zr2MrV4ept8KghJtKKbVS2AxtyRZ0PZyM83+sSHp4/LxI1uTNBgTUcj5MunakqOg4qfnJvRN2xqSqloKQymWqqld4f/aASWQuR8vy1dDbghTiTGM85rk5QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHmFM9jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E6DC4CED6;
	Fri, 21 Feb 2025 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179610;
	bh=WNL0sZKfmWiQDFD9PEb2OlcoZ6MH5kNFz9BDs90AdBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHmFM9jzRO4UimxvEMJKuqkwcIk4+JE0MSeBrT2hXhHA3B2cQA67tgE+xH2dBnUOc
	 AcOkRMZ4UhGtVh7CxvYo9PD1f8O8FD2BsexZNzMxE4441/ZVFxy7mzwJhOaJFfimG0
	 J5fvzTYbzBkEMCXC6y0H98OqWV2T9/Owmpc3oD4YVvzCPoNFEh30JDrOURHktMwkMt
	 gcmjJfDSmSiCSNIS18PgI3kDuggTwG2HZ7EIeArpho6rPZSABe+ksKcpEN+NQ2L+Rq
	 fdw7qoXlWkyQ8yWNujMFZeMOPZXzgSb6FUT19ZwIHgvnp9thPmZ/wmpdQGixNpDJVm
	 3rY4YNPY7Pt4g==
Date: Fri, 21 Feb 2025 17:13:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	git@xilinx.com, open list <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add ti,tps53681
Message-ID: <174017960656.297543.5906182002772839470.robh@kernel.org>
References: <26aac15b8f0fdbcc2633d3843e216e6c8d30bb31.1740054443.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26aac15b8f0fdbcc2633d3843e216e6c8d30bb31.1740054443.git.michal.simek@amd.com>


On Thu, 20 Feb 2025 13:27:25 +0100, Michal Simek wrote:
> Describe TI TPS5381 a dual-channel multiphase step-down controller
> supporting per-phase and per-channel output telemetry.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Linux kernel driver support has been added by commit 53030bcc87e4 ("hwmon:
> (pmbus/tps53679) Add support for TPS53681").
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!



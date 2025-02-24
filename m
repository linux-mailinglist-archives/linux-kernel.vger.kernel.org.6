Return-Path: <linux-kernel+bounces-529991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A27A42D68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569A1189131C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23123F421;
	Mon, 24 Feb 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgguWlOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66251FCCFA;
	Mon, 24 Feb 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427757; cv=none; b=d/X+ewzEzozSV9ahTWfhUwzh6xyLzRzEoIGOADCdWf5TJ89lnmo9mEHnVf+1hHRV2mlLaPDNcktMGtFw+ennxmH8T594GkXXsGHcf150reqZswGwLpomit2u1ELHaQkFlZq5wX1ZHEmh9dXJdgSM4M2hMXE467XnGpaO61VitAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427757; c=relaxed/simple;
	bh=NMza2eMoGjLrVMddzGGmTle2UIxuswjUJ47Pa1YCoXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgYs9VLs4y5QcKzCzL0Wb+CbIk5elg9pNA2mgLFQjOddHU/mhQs6UAg6kcp3kxWvBAx6ZiMLI0zFhrh+JUYUbFEaSRqsx4WSeY0ahishZ8ZgSCw7GCFfzG2abUKIzsJf2mgI+0h/PVKjIFb/N5dK8TzdRLKrsbTeWBCFil8y3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgguWlOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71EC4CED6;
	Mon, 24 Feb 2025 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427754;
	bh=NMza2eMoGjLrVMddzGGmTle2UIxuswjUJ47Pa1YCoXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgguWlOp3RZFnoQVF/Au8pu2V7A8u+U2E14a8WF9nZmHE25CzmNVhnGSOqfPsw5XQ
	 VThc4JuP+9EjX1+7zo2khaQ1B/n6egR1PP9+lRnrFvF53JnimXZ0olWtg/RN0un+YH
	 qRh7xhqcsxu78nJPMzAoTuZKa3suVg8CWMRfz4SioDfIAMDkhDzYi/XW6boDw9yYea
	 /za7LHiCNSmIU76hxEyo6cY9+h5rJewMyFmcjxijtYo2lev9elCHWO6eEyo9ekC6sK
	 AD807m/9dbEN1I+4NShH3ldhxGjiZphT181SfqglPmitpevJrhxbm8cPsZoZ4+zw51
	 Sm/maBeTrQw/A==
Date: Mon, 24 Feb 2025 14:09:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Jonathan Stroud <jonathan.stroud@amd.com>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, monstr@monstr.eu,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	git@xilinx.com, michal.simek@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	Jim Wright <wrightj@linux.vnet.ibm.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add UCD90320 gpio description
Message-ID: <174042775200.4021268.9848390633975750195.robh@kernel.org>
References: <662a050f3f8160fe7c80d4f19e45eb4fac0f2f0a.1740384385.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662a050f3f8160fe7c80d4f19e45eb4fac0f2f0a.1740384385.git.michal.simek@amd.com>


On Mon, 24 Feb 2025 09:06:26 +0100, Michal Simek wrote:
> From: Jonathan Stroud <jonathan.stroud@amd.com>
> 
> Add optional gpio device tree bindings to the UCD90320.
> The binding's description is already mentioning the number of GPIOs but
> without actual gpio controller description.
> 
> Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml     | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-kernel+bounces-563690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E42BA646BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1BA3AF349
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE2220694;
	Mon, 17 Mar 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9zA+Xp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CC26ADD;
	Mon, 17 Mar 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202735; cv=none; b=LfP2tKpYGCb6uatbkUBC38PAB24WZQAF7Gt+Tl8x5y1hiwA/GbeuUeT8hyOY0qm7nlDKsbtDf9Bil1E2aDAmsYQx2Uhyh87dHG6Z3GtXaYxrT5QMxbU7mNEtkgc2kGAmwZ3TyYFa/mtOFnd1nLuwrELVk8+2CYQY9JPUHwo5f+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202735; c=relaxed/simple;
	bh=qIi66nAJAkuAxof/+NyK+41N8iuL4BfxKI4FIhK+u1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1L5EDHVu0Vd/krmegt/Qbc5y7pPz/kciVHjTZQCqqW86bT2mEAZQx+jDV373iRvWIBnmafPdyylet6z58+gstfQ6eBz0YiI6N6tnP3oYw8bNno7l4PmEz1cdY347W1MMwne2dPDmm4cSbIRkHelw6q7l9P5X2YrC5hbi4esUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9zA+Xp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342CC4CEE3;
	Mon, 17 Mar 2025 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202733;
	bh=qIi66nAJAkuAxof/+NyK+41N8iuL4BfxKI4FIhK+u1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9zA+Xp0IhuHdLpAzNn5wQcFEUuALfNeeC+ADEXYSrdG2dr0CzGltKDfSNv7TGriK
	 xa+DMhe6aYwswcdDVsrTGyLmLVN1roHXa6MHTRukYWM1wm3xFh8h2nOEpRrMAubbgF
	 cj/GffCiF+LqdNvZRKfnHuacqjaEnIEPDcFtPERSf3TfF5kOq+1EcNR4juOWOspkuV
	 yOQTBCl/wwE6q/KPCSEDR7cw/FfuKLU9xdrNrf/jf5TvEpFVu8VNYt5u9wyH9FLFp7
	 qOzrZco6DMF9VCUnLV8zusU7wMpqzvgAIIZGJrQSACOiD5LZKUBS7qak6USSxPDrr8
	 z53XPztZlUb5w==
Date: Mon, 17 Mar 2025 10:12:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-binding: aspeed: Add LPC PCC controller
Message-ID: <20250317-hypnotic-boobook-of-discussion-fdfe94@krzk-bin>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
 <20250314112113.953238-2-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314112113.953238-2-kevin_chen@aspeedtech.com>

On Fri, Mar 14, 2025 at 07:21:11PM +0800, Kevin Chen wrote:
> Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Nothing improved. You already got comment that nothing improved and
you... send the same.

NAK

Instead of selectively ignoring comments, go back to review and
implement each of them.

Best regards,
Krzysztof



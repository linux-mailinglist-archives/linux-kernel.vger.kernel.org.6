Return-Path: <linux-kernel+bounces-565763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F55A66EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABEB3BFC22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC3205AA5;
	Tue, 18 Mar 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcjy9VLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD120296B;
	Tue, 18 Mar 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287478; cv=none; b=LGgNokt9oPdojW7Dgbh5Y1s0hcg1VTQtDx3G7+slDLJo2sy/x8enSCJni9DL4UnpEkusewTPhJCaAcWrjNhZ6Ole3XSfLDdS4NFhNDbe1Dzl3VJc2cuKXEtAT1QFZFviVrTiBFFlkkNdCy1AoAyvHyqeNFX5Uzd1ifCmWWLOR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287478; c=relaxed/simple;
	bh=NJJzNTRDknJXLfROOfBbxIWmcgwRhNCep316udiZ8FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rce9rFukq1+pPYztWQ+8D4B8NZ3QayPUQr1Vubi2pJDGa6cyMy0Te+RTqQq0ea7+EZkTeldvAFaQYS0r91BgeC7O07T+qmrStXGkmixMRCZgpUkzZJoXdLnbRJJFfSJ87JPf0/rOtlUPEfE63M/PWo39+lVMJmgOb0ybmfOZL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcjy9VLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F26C4CEEE;
	Tue, 18 Mar 2025 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742287478;
	bh=NJJzNTRDknJXLfROOfBbxIWmcgwRhNCep316udiZ8FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcjy9VLpm33mUCfRhkjxGfHVKu2TRRnc0L7RRFbXPRNp3r7sRwU+SGolTYvRgxad/
	 FwrYDkGR7UWaS6UxVNa7uaERBHjXdjuxmQRbP8c+eviscDzV3YuXIPRz8lPS6HTKG5
	 j6uKWvegpcFbDrSRVS5iivttq4ClLUl1OeUkF4jHtJ8wYcXkudUmHyg8tyCc+M+2ak
	 I7SCoHCE6aM6LTyiT6cMwfIybdESxIl5J1Q+8et1sTn+FcQm6+4tJAD163vJ6/STnD
	 qs/mAVThJo6P11hvsFWOnyermYuC+S+XHG/WeBWA+DZogl5w6QMgR3i9K6Kt2tDO+W
	 vm8+i7qKpm1kg==
Date: Tue, 18 Mar 2025 09:44:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC
 compatible
Message-ID: <20250318-rapid-coot-of-tact-d779ad@krzk-bin>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>

On Mon, Mar 17, 2025 at 11:12:23PM -0500, Rajaganesh Rathinasabapathi wrote:
> Document new AMD Onyx BMC board compatibles
> 
> Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
> ---

Where is the changelog? What happened with this patch between v1 and v3?

Best regards,
Krzysztof



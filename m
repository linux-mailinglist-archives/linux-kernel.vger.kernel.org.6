Return-Path: <linux-kernel+bounces-575941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEFA7091B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DDE16C2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985A1AB6D4;
	Tue, 25 Mar 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dir+ebun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA0190679;
	Tue, 25 Mar 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927764; cv=none; b=I1L/d48u9mgOAXPHAdbYhk9u5pOw8JV9HKElZ6YtnPxFKKnF83R1Zki3T2+PKvfCsH1CaO8cyjkXt9EbwWjZlBImGWpuSpZPKVnOXhOmF7xETftpSfKeI2PBdgIljZ1DXjf8nurOWBLNUkbrGFrlCqUAjYXZM5f8fQkv1londV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927764; c=relaxed/simple;
	bh=w+7Li448Kkx5T5mvWuA7o6lNSzeRXpD6Dihs32MoXwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8geLuQ+WxSnwpNRkG3C2/qK7A1aTyjXYyocngL1/t4cUNsZMK40dn1i7xxTXgpzfjJyE68J/ovHCpUgVgWOUyWxQ1hK1FhC3E0K1eCkZ3LfAjOK4MZyQqake0DRAoZsmdxJxzG0gmkiiQoGcBRjiSQFZ8z7qqrvbHWhndyezXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dir+ebun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB7C4CEE4;
	Tue, 25 Mar 2025 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742927763;
	bh=w+7Li448Kkx5T5mvWuA7o6lNSzeRXpD6Dihs32MoXwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dir+ebunYRqT/TkgwYLbmDOdCv3n9PkaU5hPkgpPdiGgg4+9lFrQePwTEi9eljnoG
	 yLbNKGEuG9FRxmbVbXE1RPuU5stvfVhT08w9oE2a1fM+vXTDOrY6hPwEtNT5LutiEr
	 oVzxPtNCKKAAAPdyiTspL861qLsKC8+5X4TRtSrdQs0GhBCjEjmYsDKVjjF1PXv8/t
	 lHXk534w2Fbia/5XW0njpnX724ua4F9GvvJkcBfnYrDTiQpOsZ3wS8ogVVFA3wJYqL
	 0PunP8/EnykVaT9zs1c/1f4NdfAej83Wrnf95N7AlaEtOnLlGpoDyt7PnmMR37VZUo
	 HSc8JoXxkMJ0Q==
Date: Tue, 25 Mar 2025 13:36:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: edac: altera: socfpga: Convert to YAML
Message-ID: <174292776178.2114668.8032806349344866356.robh@kernel.org>
References: <20250325173139.27634-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325173139.27634-1-matthew.gerlach@altera.com>


On Tue, 25 Mar 2025 10:31:39 -0700, Matthew Gerlach wrote:
> Convert the device tree bindings for the Altera SoCFPGA ECC
> Manager from text to yaml.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v3:
>  - Remove redundant $ref and description from compatible entries.
>  - Add $ref and description for altr,sysmgr-syscon entry.
>  - Fix description of altr,ecc-parent of sdmmca-ecc@ff8c8c00.
>  - Successfully validated Cyclone5, Arria5/10, Stratix10, and Agilex.
>  - Rename yaml file.
> 
> v2:
>  - Fix $id: path.
>  - Remove unneeded '|'.
>  - Move vendor properties last (but before child nodes).
>  - Add appropriate blank lines.
>  - Don't break ABI.
>  - Avoid changing existing DTSI and DTS.
> ---
>  .../edac/altr,socfpga-ecc-manager.yaml        | 323 +++++++++++++++
>  .../bindings/edac/socfpga-eccmgr.txt          | 383 ------------------
>  MAINTAINERS                                   |   5 +
>  3 files changed, 328 insertions(+), 383 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
>  delete mode 100644 Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> 

Applied, thanks!



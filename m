Return-Path: <linux-kernel+bounces-565768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9304CA66EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078A1188C29B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1732046AF;
	Tue, 18 Mar 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gifhvEIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C11F8741;
	Tue, 18 Mar 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287632; cv=none; b=KNtkibWUbkS1p+fxNqAqfT8QAUqQ4WHe/S311jU1Bwq97jRSPE5UunPAu1B5bXa0F5wfa5TQes1ETsdYn5+w5BqZ1LuWYpq25dVRPvnpKoz96lFEFvWAbuqcc9G6nEAaCjv4eIXd++m/IuDyJe7f0nEBS1yilAevr/+uuv2tNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287632; c=relaxed/simple;
	bh=HQ18tF+vLFwjCAPLVoMbPytiGkV0mVtbv5FTGc6N9d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re9YfFDLArh7g5EtM+Bo3ELilFLwv8v7L29MGzPuwEvU1D09Sqk2Yx19l1RiXANOPj9P0T/6YX3/zOuHKz1cnWy98SX96QGtA2wk2V+G7LNiYh94hbYKriJ2htbk9nHXukwKgpRGBjE/5tE3DcqMZH6GDrDgTUdqEnQPlRHO0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gifhvEIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33534C4CEDD;
	Tue, 18 Mar 2025 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742287632;
	bh=HQ18tF+vLFwjCAPLVoMbPytiGkV0mVtbv5FTGc6N9d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gifhvEIT4T1QbmI0T9/M0h5PNt6rcZjxObOvkuPiUxK5Ffluz+YfsxoouO5wmVTBd
	 iLV1Bd0dLg0Xwx7Gi4n1HS+AxpXefq1LEkWh7mP4mD03gKPL/la/eCmwp3gi0AkCw6
	 8wyP5srUbdlPlcNK9lVgn07Su5cZJ09GXrQ+ufmbmVAhbN9fBudGu+RhjmwUGqaU3k
	 y8Hm9Ay8n2IknaQfFr5CMstcML2welXS9iEehlPUqnaiJx7ot8CiCcAxSL/hsvgWR6
	 WnNhpi9ZjMRXJ8sICENnSY2uXg0n5lJMZAGkMGBOablnonq1iOLzrOqNWnJbonFNyg
	 /bKSmrO2FYKYA==
Date: Tue, 18 Mar 2025 09:47:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cy_huang@richtek.com
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regulator: dt-bindings: rtq2208: Mark fixed LDO
 VOUT property as deprecated
Message-ID: <20250318-thick-knowing-petrel-ad89db@krzk-bin>
References: <cover.1742269337.git.cy_huang@richtek.com>
 <8400088f3b68842ee63b6fa768fe2c545c473acf.1742269337.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8400088f3b68842ee63b6fa768fe2c545c473acf.1742269337.git.cy_huang@richtek.com>

On Tue, Mar 18, 2025 at 11:53:54AM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Since the check for fixed LDO VOUT can be identified by the HW register,
> mark the unnecessary property as deprecated.

Also cleanup white-space.

or separate commit...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



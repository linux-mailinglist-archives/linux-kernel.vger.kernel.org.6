Return-Path: <linux-kernel+bounces-375628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76419A9863
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907E283572
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADE1311A7;
	Tue, 22 Oct 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdeJe7zu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C6225D6;
	Tue, 22 Oct 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575029; cv=none; b=uzRq6ZeEtDR2soRA5KPHweb/bK0n4V9KBoz1/xb3djs86T/uZuKzz79/X/PC4BwIEZqXT1OzQTQnrFsd/LqEYrRz9Jo+ndZSTabPukLWFVMxy3Gla7+vK2vd6XBBV3RpnxnekDy7M01eFm+ahRFrdArNBh401p6RC5EPaMdgGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575029; c=relaxed/simple;
	bh=OhuEP3iAmT3aVRy1EVC97fMg4aiD6lXm5gqGEzG6WIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChAHuGHBlclyHOPVyzea+x3dK6IQZdXypHrSKiwTfmF49Tdw1IAzBnf5dIpxwnciModUxo5zOec/+n6APoPo9tNtRXwH0iJtu9hz82zvj2t4cbNHSCnHcdfs6RnhjmHAzOj6ttT3Yi6llX1JnTgoTZYqSLJ/gj4n/nuXYyMs2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdeJe7zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8300BC4CEC3;
	Tue, 22 Oct 2024 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575028;
	bh=OhuEP3iAmT3aVRy1EVC97fMg4aiD6lXm5gqGEzG6WIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdeJe7zuMVC0rx/cef/VKjc06YSYGx+9FB99smfpTncLLzqB8sv5+jsoArBSblOfz
	 7yYM1be2/XbC2qpoFPEP7+e4RgFd1j0P29PdYWhDf9RhoxwFQ82dmKRnrNQjuUVY/v
	 9EWJpY6W11EQZjRVfmOPgAqERNR82pcbMdhJPK3NjvH5fPxkIy2hKYc+Gu11gcbzRI
	 yZTnfspjzdlVHwZHXk8UofNmgQ/R+BwEQ/dKfamx1u745d7s/rHaKqqk63sGmEbGsS
	 n+EOSz/zscq2bTbmw95+zFuYUEMXMP5cgMR2LcYUvqLeogxHmroirvE9mRF4IklxMd
	 0Ll8t0pN6KThw==
Date: Tue, 22 Oct 2024 07:30:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
	linux@roeck-us.net, sylv@sylv.io, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: hwmon: pmbus: Add bindings for Vicor
 pli1209bc
Message-ID: <nruailq552fzhxfmahtlzkw3smqkvi373htlmfbcvbxjqybfh6@g4jzuyiabw3c>
References: <20241021123044.3648960-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021123044.3648960-1-naresh.solanki@9elements.com>

On Mon, Oct 21, 2024 at 06:00:43PM +0530, Naresh Solanki wrote:
> Remove vicor,pli1209bc from trivial-devices as it requires additional
> properties and does not fit into the trivial devices category.
> 
> Add new bindings for Vicor pli1209bc, a Digital Supervisor with
> Isolation for use with BCM Bus Converter Modules.
> 
> VR rails are defined under regulator node as expected by pmbus driver.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V3:
> - Fix indentation
> Changes in V2:
> - Squash the two patch in patch into one.
> - Update commit message.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-203783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D68FE073
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC681F27045
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F113BAD4;
	Thu,  6 Jun 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN2qNMJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB713A898;
	Thu,  6 Jun 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660883; cv=none; b=oAe2NhLbycpIcbkXyIGRhAw0QHvgkY7SmUo90NkB6qH6WZVrQ9fzfrS7A16iGrBOqinjTqeKEJ2bSvpy4Gj5V9bRdAp3QcOaMoaqLQRBOHvaw88v7UhqjIqWqljGsNFgrYix6n8GxQ2TokOCyeSyZUIKeoQ0tbXgGJBc1aS914U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660883; c=relaxed/simple;
	bh=JjZfQEGREoDEytQxsFvsAY+xhsDc+CeN+l5OkrnoTog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWAxqhB+Kvllgol3A0Wnc3dzaThDrm0zoBiDWKZ2DonHAKgE1CVJmECTCYxo2Kwz4TeroBlkx9c5dFnwg/HVCf+VDKZg6sqBBwm2mz5k4BadF6yfDcOZjzM5r8xiR0dxdYfTlHzx+wAknXyUzQ2JW2O03cIavB5WjhJgg4mFMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN2qNMJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE08C4AF0C;
	Thu,  6 Jun 2024 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717660882;
	bh=JjZfQEGREoDEytQxsFvsAY+xhsDc+CeN+l5OkrnoTog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZN2qNMJp9g9E5S2iur9H4enJK5Kr6le0DNPEHjknKX+ikbdMMj4pjujin4lvurFzI
	 MsFZHEr6jBa9pXqga/Vm9Q3/HjgWxH0dmIMEyR01+znuMGLWmGvD2yXa9mLB63JEv9
	 /eYLnrZzjSo0s/uOh9AESgi0Khy/H6x+oSidrNSRkV3k9OG5ZrBRGXDEcn0vJOF5Dd
	 W7/vNfC6oOnkeiEaYjCuHhIA8NUa43oyJGwyFga5cm9BUR0XI+ZtbuQspLFfne2B6i
	 wtU0zcrvjDXpGg6c7HazqExgCENuqaHZTIPHqe0ancdRVmFqejYIRa4ZfbNQLONwE4
	 U10ezfJssT3/A==
Message-ID: <ab50dd05-3f21-47ae-b317-e1700a495834@kernel.org>
Date: Thu, 6 Jun 2024 11:01:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] arm64: dts: ti: k3-am62p-j722s: Move AM62P
 specific USB1 to am62p-main.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-3-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> The USB1 instance of USB controller on AM62P is different from the USB1
> instance of USB controller on J722S. Thus, move the USB1 instance from
> the shared "k3-am62p-j722s-common-main.dtsi" file to the AM62p specific
> "k3-am62p-main.dtsi" file.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>


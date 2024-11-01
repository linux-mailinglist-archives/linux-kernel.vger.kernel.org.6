Return-Path: <linux-kernel+bounces-391785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EBB9B8BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D022824EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1E1509B4;
	Fri,  1 Nov 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl+hyo2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8C12BF24;
	Fri,  1 Nov 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444532; cv=none; b=RiDQpcPs0uVdGQ3F9UK1H6tuvWSyRFhHpw4aL+Yd70AJ9HPU7bST7qieuP2W8hoFNuwt/+29vP/8vhafLrDDwrvhryoVfPO7nTggBH5W9yJZJx0eqZZ7ZpG+NzSVd4xWPdfbTIdyylaz2UcJW+5+3Ss5oT6JW7kDgpCsfcpziVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444532; c=relaxed/simple;
	bh=rHH169qaZTiJl0gLMfxJLR5YBm5hTCcLIsFp6V79Z98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW7M1dzEVV6qXQNGqXTuCSVUAf2LOLY1R6r/cyuTGWeTOIkZ33JKgILVsT/AQtVth+TdfGf9MRXnBc3qMpjlWwOGS/srVLk1kktQodaAxrdF8pnHufUWGyFcIuH/qZkJJPRmtCUZhW2vEKZzuDK0CWqzCRN/tiqyk/vlsxn+3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl+hyo2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD47C4CECD;
	Fri,  1 Nov 2024 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730444531;
	bh=rHH169qaZTiJl0gLMfxJLR5YBm5hTCcLIsFp6V79Z98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gl+hyo2Pxjl8y3WwiP/hYBe00cAvQvpSOCU6PVMQZ/77BACSBtoLMfMsu4aUZ71RM
	 dl4lxUUnL/9ui/TvHlR/RRK8D0nHpHqIC7hocnvW4o5AABXefZFogmXivXRvdL3Z57
	 ulfXFoQvr6oKys6E5RZuIeyK2BY9VYkymYdM4ocjI336ymVaNIvsdUYgBBvmZh5H7H
	 13mI/tetnIjX3ii3z26Yi7i0EujBwIfzrQ5aCBoHS9sf8EsGU3vHfQE0dlIhkWIc+N
	 6DagPZPMfuTqaYWs68myYM2mjVKd2rOGTv6Cd3LY/3fxTufC+gq6lo2BSGwUCI/vBQ
	 Qj8S+kaWnjFsw==
Date: Fri, 1 Nov 2024 08:02:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org, 
	kyletso@google.com, rdbabiera@google.com, badhri@google.com, linux@roeck-us.net, 
	xu.yang_2@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: maxim,max33359.yaml: add usage
 of sink bc12 time property
Message-ID: <r44xdvk53c45bhyvwhy6722vj7wttkhfesta3ty22kkt6nfrtu@vcooujz3ywlj>
References: <20241031235957.1261244-1-amitsd@google.com>
 <20241031235957.1261244-3-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031235957.1261244-3-amitsd@google.com>

On Thu, Oct 31, 2024 at 04:59:53PM -0700, Amit Sunil Dhamne wrote:
> Add usage of "sink-bc12-completion-time-ms"  connector property to

There is no such property. You cannot add it. You did not even
test this patch before sending :/


> max33359 controller for delaying PD negotiation till BC1.2 detection
> completes. This overcomes the occasional delays observed while
> receiving PD messages where BC1.2 detection runs in parallel.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Your Reviewed-by tag is pretty wrong. I don't believe any review
happened here. If it did, it was pretty useless.

Best regards,
Krzysztof



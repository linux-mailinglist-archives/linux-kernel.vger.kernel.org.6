Return-Path: <linux-kernel+bounces-391795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB89B8BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFFA282D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463D157487;
	Fri,  1 Nov 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGuViO/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34100156C71;
	Fri,  1 Nov 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445017; cv=none; b=uFYDcwYdmaJLg5ZQg6g8S+IoiTcqa38iB545nkUN+9pOyzk4Zxasv4xw3GCmzR50UxRfdMiqTxzP8pYcPfbHxAX0cELC3NF6/XLXBjFAnWx0kfS2F+O2JxW7YvWmeX1sOFzgkulbN+M1d4KN+t1Q8GyfaukO58e/H0EYbI5E7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445017; c=relaxed/simple;
	bh=zY3WMOKg8ZP5ncaaz71lq+aHgddJsIqIZpoCnMhaRyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF/KmFJsoZbMdZ0MDZ3OZc7YRf9bKLknZDgpsFdzhfEp+dbbYxTzxkJD/vnVhCLn+YimvV9fGv6M1vEevV7iF5b5yrOYJQOX4u8MrT+ETERkABEsZd43PZADMfR4ybD5TIohnyCYBgDdntbaQCmCWhVtxOqpegYezJYlR0dqeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGuViO/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E133EC4CECD;
	Fri,  1 Nov 2024 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730445016;
	bh=zY3WMOKg8ZP5ncaaz71lq+aHgddJsIqIZpoCnMhaRyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGuViO/zKnaZ7gu+6o4OtswkdUSpQBwN7amZAKatBl5k114H6vFQoNH4qT+zpjojJ
	 mWg5/GmTINFQ9shszj2IZPA51GuP2f/x3FdJTYJRgnIJcnHtSSHfmO/pzjCkWl+5ic
	 OYTzRwmYAT0ZgZXNA8rcAHmXGnt1S7YiYzAWoN+hjQ+/hF/y4WBbrU4jGgw8LZ1oFe
	 +uBX4j3DnwzGwQxqa7CwTxYqc/J6D/dytIh8Or87JR08CZVSWwK4EUGYyI0wFTqsBS
	 peP8gQtGBpi0BZHv6Y0W1sBigfk3nbNLsJwHtkvm/FjOR9GnnQNm8Nm4DYRV9TY2nF
	 Rptp8pF4bnOMQ==
Date: Fri, 1 Nov 2024 08:10:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org, 
	kyletso@google.com, rdbabiera@google.com, badhri@google.com, linux@roeck-us.net, 
	xu.yang_2@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: connector: Add time property for
 Sink BC12 detection completion
Message-ID: <zdbnxzv2q4lfer5hvdtcuzr3jfligi7y3qs2o5w2orrw5rcpkg@f3wvcwdntklf>
References: <20241031235957.1261244-1-amitsd@google.com>
 <20241031235957.1261244-2-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031235957.1261244-2-amitsd@google.com>

On Thu, Oct 31, 2024 at 04:59:52PM -0700, Amit Sunil Dhamne wrote:
> This commit adds a new time property for Battery charger (BC1.2) type
> detection completion process (based on BCv1.2 detection spec) when
> typec port connects in a potential sink role. BC1.2 detection is used
> by some Type C port controllers implementations (such as
> "maxim,max33359") to detect the type of charger port.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 21a0c58c65cd..67700440e23b 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -283,6 +283,16 @@ properties:
>      maximum: 200
>      default: 200
>  
> +  sink-bc12-completion-time-ms:
> +    description: Represents the max time in ms that a port in sink role takes
> +      to complete Battery Charger (BC1.2) Detection. BC1.2 detection is a
> +      hardware mechanism, which in some TCPC implementations, can run in
> +      parallel once the Type-C connection state machine reaches the "potential
> +      connect as sink" state. In TCPCs where this causes delays to respond to
> +      the incoming PD messages, sink-bc12-completion-time-ms is used to delay
> +      PD negotiation till BC1.2 detection completes.
> +    default: 0

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



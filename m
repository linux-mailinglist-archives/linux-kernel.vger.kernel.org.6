Return-Path: <linux-kernel+bounces-371145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0D9A3707
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87B51F222F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75018A6B1;
	Fri, 18 Oct 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddbPjORv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C13184535;
	Fri, 18 Oct 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236133; cv=none; b=AMaMnpenGIN5opRB3W7FDRHusYyOqChmXw3ccizs7pIBu9lDuoQz3+g//zzQyTZWve+Fwb3IKhBo0dKnW2U66bR0EM3bY0xW6EaC/POuhaalG3aDyExlhXn3e/9zwkOcBeidWujpUHPdanJpsQSQfN1jkO7Pk27Npyz52uQeWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236133; c=relaxed/simple;
	bh=gfAbcBZqSN2T7nVnw2LAScinwTroT/+/pbAspeU7OBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td5bfrX8/HW6Wu9BznSfZAzWNWhn6L2I84PPGTDq1LNUjZF21mdjw+VwZSEetA5znmO+dfathhoOeEa7G3NfTgUnEXtunRS0pcBAyy+BpBcIQUJFdcbWHIUSoQW1MFxo95x78fItBlnczGWSxYA+3mviJQ+RdFVP7z7jX8XG2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddbPjORv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C83C4CEC3;
	Fri, 18 Oct 2024 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729236132;
	bh=gfAbcBZqSN2T7nVnw2LAScinwTroT/+/pbAspeU7OBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddbPjORvxgL5qP58LSmP2tSroPj4og9dQhROiyZH7iDtR0r5a3WfnR2cix9C9J7h9
	 Hh1w/6RDzAiO3XvLG0C70m/BvOt9IhW2Bj9J7Cm8Gdo+NjK2VDmIP6fJczaVZAz4h6
	 HTskkqtarvk9+qBXjBz42VwA4WsFNXCt8KxlY08vlenF1PA8suBhWNdGk3t9z4Gvw5
	 EdfZT5yjkBxXABAHfXPjGJZRlhhcmzVmUTXm2UCFxVKIACwn2I2NAHNAmmZpSDq37s
	 1WBCsdsZlXaShC6mcgh3kscU5hYB1+VebQ/Eg9X0pqof8fSiLxjxfLQHohEjXU/bdv
	 lOknu8pYypARw==
Date: Fri, 18 Oct 2024 09:22:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: qcom,qfprom: Add SAR2130P compatible
Message-ID: <nuj46aoqnj2hqi5hosurgwrox7zqwwuwtobfb6mzgwklq2qbtf@yu2t3stsy7b4>
References: <20241017-sar2130p-nvmem-v1-1-6cc32789afc6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-nvmem-v1-1-6cc32789afc6@linaro.org>

On Thu, Oct 17, 2024 at 09:18:10PM +0300, Dmitry Baryshkov wrote:
> Document compatible for the QFPROM on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



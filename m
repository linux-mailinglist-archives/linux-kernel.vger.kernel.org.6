Return-Path: <linux-kernel+bounces-307516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51607964E69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D8281ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE01B9B48;
	Thu, 29 Aug 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1hxIe0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C031B653F;
	Thu, 29 Aug 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958342; cv=none; b=qg690zLu1gkvTuWd+/pu4V2HwKpZwxyCNkwL7/DqtcqPg5q7a0RgknHxhwK8CU7nzw60bfq0mykE8NtOLyXbTH3avMakznJ9kOEAd4CYqxZCU4aEqvMIhC4GiN1TkjUG1L/0Y79hoIrVNZJXYnHozgrQRlLAJ+SkYkTiaJ9TJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958342; c=relaxed/simple;
	bh=+SZQLpVJ8uBaeU5qY67xtR7CmHxItAC/gNqe+glMAAA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvVZNZ/D08Ws7NHZoI73YdPyZei/gZZSqgWGy+3G87eNROpsrlrtlTwpAGPVxM4naYuaT/KV5GyH15L4xzwMgbvyIYl2df9PRHev2nFzMN56TgGIjU7WHuNzQUMcKRqOIjKHAOzfvQNi6xFJMIVU0aF/QOOAdYo9qgvLz9b/iSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1hxIe0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1368CC4CEC1;
	Thu, 29 Aug 2024 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958340;
	bh=+SZQLpVJ8uBaeU5qY67xtR7CmHxItAC/gNqe+glMAAA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=S1hxIe0d3E9kfj8avwxgwVbTtvOGTw4P+3UGKoWkQuF+7HVc8SEn4EeMA5uRPmqBg
	 7o6343p/clSm9eaKNrZY9gWvxtP2DmWpyGh4lle7dUWjtgv7KPfDqjvHWL3kYQXJMO
	 644GgMJ3IWv0kIhJAPujtHdNUc8yXgg9Y8UwR0qV/4oe/5kk25beT4yTazggEnA67v
	 3OQ/LfengsI7bENaTX5r92eWGhiQ0TdZGSOgtDzmeYSuek6IXCoVUUrqfVJl/mPU2V
	 hK53BiXzlfpobX5moPQinJ5IFz1lXjs06nhDS9TQnTHenQkAGjFREcZ9XAmbgbE757
	 ngYEmMVXY9Hig==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
References: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: socionext,uniphier: add top-level
 constraints
Message-Id: <172495833772.405683.9269300572581371262.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 00:35:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 18 Aug 2024 19:28:35 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: socionext,uniphier: add top-level constraints
      commit: 45a4237b9be24d6c93db9da2b2180810c5bb2929

Best regards,
-- 
~Vinod




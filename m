Return-Path: <linux-kernel+bounces-398309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C859BEF66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D625C28460D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F818188CC6;
	Wed,  6 Nov 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ap4UrAy0"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899311B815;
	Wed,  6 Nov 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900824; cv=none; b=QbjH0s/AAcHhiRIOTD7uwRKAUNkG/A5mKdBQDfgf5vcEjZJjo6UjgWItNC50UbXhgn34DK0oR4FtAwXMRa6RpjiRVZ1NbAt6rBT4TT637W0RGgiBypfozUEUwvBPKWABqXrLbm5GcLlinNJVdvtPTJNd6UmJvD8wQuQ9kSzGh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900824; c=relaxed/simple;
	bh=DcsSDzWABEoRx9+rVwQ4zZ7q0BqP3wOw8JBIDTEtAg8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rTQ0qXz+Y1CQ7aL9QlyGR6fp/nDrO6BGEskCHUFkCIpk7nOqOJLVfvn55NVegTZEe7zzMbxnpyBNKtpyZSBwn1cww7xD8Y8LuWHYAPHeE8s2+UBpN517Iolqpbds8Q0/S2yWVFpKxMTYal/kiRMc0W39zvjNadXqpx/rjbjZjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ap4UrAy0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4517FFF80D;
	Wed,  6 Nov 2024 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730900819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jS9ARMh9Y9zzPLoP6cvtPSgZW8OdvTwj6Wc+hiaVYs=;
	b=ap4UrAy0ODDkvHHt2r9+9EQvcwSwFgJBHTBquhkPXJEfD3nIYM5LPYkdHdldrJ0OJ9t/2J
	FWNGQSDCFeQ9lSRudUePSB4+2MKXJRD6+ozKYleXjJsj1wrd7B6zSo823h3Qq+zmz5+X4b
	uPGV4P/2J4YS5QdsHOk0neO3K8G/1/L0GWrcdjaVqyH3f0BDvmJLpKlyMYo8Josp7f/Wxx
	/EcvZ6/p/qDDhxTBSHemMrRGbFNxr00CuaNUWaA5vZhRVkptrnYFsL17/nmvxjm8nSQIBZ
	MvHzWzxo3RKM67OZ9IVV98guAGJIwhk3u4NffNhizgTpkE5Mh1fg9RqwwWbAxQ==
Message-ID: <b85a7486-578f-42c9-9ec2-b5befa75d893@bootlin.com>
Date: Wed, 6 Nov 2024 14:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
 <20241104-congatec-board-controller-hwmon-v1-1-871e4cd59d8e@bootlin.com>
 <d699cddc-a8ae-4094-b1b5-7af8cd7e91cd@roeck-us.net>
Content-Language: en-US
In-Reply-To: <d699cddc-a8ae-4094-b1b5-7af8cd7e91cd@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

Hello Guenter,

Thanks for the review !!

> 
> For the first loop, this essentially repeats the cgbc_hwmon_cmd() from
> above.
> Is that how it works, i.e., that index == 0 returns both the number of
> sensors
> in the first byte of return data plus the data for the first sensor ?

Yes it is.
This is based on the Congatec implementation.
First time I read the their code, I had the same reaction than you.
But it works.

Please note that the driver provided by Congatec is the only source of
information I have (there is no technical documentation which describes
the internal behavior of this Board Controller).

I'll skip the cgbc_hwmon_cmd() for the first loop and add a comment to
not forget that it is not an error.

> 
>> +        if (ret)
>> +            return ret;
>> +
>> +        type = FIELD_GET(CGBC_HWMON_TYPE_MASK, data[1]);
>> +        id = FIELD_GET(CGBC_HWMON_ID_MASK, data[1]) - 1;
>> +
>> +        if (type == CGBC_HWMON_TYPE_TEMP && id <
>> ARRAY_SIZE(cgbc_hwmon_labels_temp)) {
>> +            sensor->type = hwmon_temp;
>> +            sensor->label = cgbc_hwmon_labels_temp[id];
>> +        } else if (type == CGBC_HWMON_TYPE_IN && id <
>> ARRAY_SIZE(cgbc_hwmon_labels_in)) {
>> +            /*
>> +             * The Board Controller doesn't do differences between
>> current and voltage
> 
> doesn't differentiate
> 
>> +             * sensors
>> +             */
> 
> This doesn't really explain what is happening. Please add something like
> "Get the sensor type from cgbc_hwmon_labels_in[id].label instead".
> 
>> +            sensor->type = cgbc_hwmon_labels_in[id].type;
>> +            sensor->label = cgbc_hwmon_labels_in[id].label;
>> +        } else if (type == CGBC_HWMON_TYPE_FAN && id <
>> ARRAY_SIZE(cgbc_hwmon_labels_fan)) {
>> +            sensor->type = hwmon_fan;
>> +            sensor->label = cgbc_hwmon_labels_fan[id];
>> +        } else {
>> +            dev_warn(dev, "Board Controller returned an unknown
>> sensor (type=%d, id=%d), ignore it",
>> +                 type, id);
>> +            continue;
>> +        }
>> +
>> +        sensor->active = FIELD_GET(CGBC_HWMON_ACTIVE_BIT, data[1]);
>> +        sensor->index = i;
>> +        sensor++;
>> +        hwmon->nb_sensors++;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static struct cgbc_hwmon_sensor *cgbc_hwmon_find_sensor(struct
>> cgbc_hwmon_data *hwmon,
>> +                            enum hwmon_sensor_types type, int channel)
>> +{
>> +    struct cgbc_hwmon_sensor *sensor = NULL;
>> +    int i, cnt = 0;
>> +
>> +    for (i = 0; i < hwmon->nb_sensors; i++) {
>> +        if (hwmon->sensors[i].type == type && cnt++ == channel) {
> 
> Isn't that a bit fragile ? It assumes that the nth reported sensor of a
> given type
> reflects a specific named sensor. If that is indeed the case, why bother
> with
> all the code in cgbc_hwmon_probe_sensors() ? The index to sensor
> association
> should be well defined, and the sensor type plus the channel index
> should always
> be a constant.

I'm not sure to get your comment.

I cannot assume that the sensor list returned by the Board Controller
will be the same for all boards.
I know the MFD driver only supports one board, but I think it's better
if we can have a generic hwmon driver.

If I add some debug in cgbc_hwmon_probe_sensors() I can dump the sensor
list returned by the Board Controller:

cgbc_hwmon_probe_sensors: index=0 type=1 id=5 label=Chipset Temperature
cgbc_hwmon_probe_sensors: index=1 type=7 id=0 label=CPU Fan
cgbc_hwmon_probe_sensors: index=4 type=1 id=3 label=Board Temperature
cgbc_hwmon_probe_sensors: index=5 type=2 id=1 label=DC Runtime Voltage

It is the type and the id which give the name of the sensor.

I don't see how to do it in a different way if I cannot assume that the
list above is not the same for all boards.
If I assume that the list returned by the Board Controller is always the
same for a board (which I not even sure, if for example a fan is
plugged), I could have a static list for each different boards. But the
driver will not be generic.

If I miss something, please let me know.

> 
>> +            sensor = &hwmon->sensors[i];
>> +            break;
>> +        }
>> +    }
>> +
>> +    return sensor;
>> +}
>> +
>> +static int cgbc_hwmon_read(struct device *dev, enum
>> hwmon_sensor_types type, u32 attr, int channel,
>> +               long *val)
>> +{
>> +    struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
>> +    struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon,
>> type, channel);
>> +    struct cgbc_device_data *cgbc = hwmon->cgbc;
>> +    u8 data[CGBC_HWMON_CMD_SENSOR_DATA_SIZE];
>> +    int ret;
>> +
>> +    if (!sensor)
>> +        return -ENODEV;
> 
> How would this ever happen ? Unless I am missing something, that means
> there is a bug somewhere in the code. "No such device" is definitely
> wrong here (and elsewhere). If you don't trust your code and think
> this can happen, at least return -ENODATA.

I can remove this return -ENODEV (and also the one in read_string()).
The read() and read_string() callbacks can only be called if the sensor
is created in sysfs.
And the hwmon core creates the sysfs entry only if is_visible() does not
return an error.
The function cgbc_hwmon_find_sensor() is called in is_visible() and the
returned pointer is checked.
So if read() or read_string() is called, we know that is_visible()
didn't return an error, so cgbc_hwmon_find_sensor() didn't return an error.
So this "return -ENODEV" (in read() and read_string()) is dead code.

> 
>> +
>> +    ret = cgbc_hwmon_cmd(cgbc, sensor->index, &data[0]);
>> +    if (ret)
>> +        return ret;
>> +
>> +    *val = FIELD_PREP(CGBC_HWMON_DATA_HIGH, data[3]) |
>> FIELD_PREP(CGBC_HWMON_DATA_LOW, data[2]);
>> +
> 
> That is a pretty complex way of writing
>     *val = (data[3] << 8) | data[2];
> I'd say that is close to obfuscation, but that is your call.

I agree, it's easier to read.

> 
>> +    /* For the Board Controller 1lsb = 0.1 degree centigrade */
> 
> All other units are as expected (mV, mA, rpm) ?

Yes they are, I will mention it.

> 
>> +    if (sensor->type == hwmon_temp)
>> +        *val *= 100;
>> +
>> +    return 0;
>> +}
>> +
>> +static umode_t cgbc_hwmon_is_visible(const void *_data, enum
>> hwmon_sensor_types type, u32 attr,
>> +                     int channel)
>> +{
>> +    struct cgbc_hwmon_data *data = (struct cgbc_hwmon_data *)_data;
>> +    struct cgbc_hwmon_sensor *sensor;
>> +
>> +    sensor = cgbc_hwmon_find_sensor(data, type, channel);
>> +    if (!sensor)
>> +        return 0;
>> +
>> +    return sensor->active ? 0444 : 0;
>> +}
>> +
>> +static int cgbc_hwmon_read_string(struct device *dev, enum
>> hwmon_sensor_types type, u32 attr,
>> +                  int channel, const char **str)
>> +{
>> +    struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
>> +    struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon,
>> type, channel);
>> +
>> +    if (!sensor)
>> +        return -ENODEV;
>> +
>> +    *str = sensor->label;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct hwmon_channel_info * const cgbc_hwmon_info[] = {
>> +    HWMON_CHANNEL_INFO(temp,
>> +               HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT |
>> HWMON_T_LABEL,
>> +               HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT |
>> HWMON_T_LABEL,
>> +               HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT |
>> HWMON_T_LABEL,
>> +               HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT |
>> HWMON_T_LABEL,
>> +               HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT |
>> HWMON_T_LABEL),
>> +    HWMON_CHANNEL_INFO(in,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL,
>> +               HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT |
>> HWMON_I_LABEL),
>> +    HWMON_CHANNEL_INFO(curr,
>> +               HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT |
>> HWMON_C_LABEL,
>> +               HWMON_C_INPUT | HWMON_C_LABEL),
>> +    HWMON_CHANNEL_INFO(fan,
>> +               HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT |
>> HWMON_F_LABEL,
>> +               HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT |
>> HWMON_F_LABEL,
>> +               HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT |
>> HWMON_F_LABEL),
>> +    NULL
>> +};
>> +
>> +static const struct hwmon_ops cgbc_hwmon_ops = {
>> +    .is_visible = cgbc_hwmon_is_visible,
>> +    .read = cgbc_hwmon_read,
>> +    .read_string = cgbc_hwmon_read_string,
>> +};
>> +
>> +static const struct hwmon_chip_info cgbc_chip_info = {
>> +    .ops = &cgbc_hwmon_ops,
>> +    .info = cgbc_hwmon_info,
>> +};
>> +
>> +static int cgbc_hwmon_probe(struct platform_device *pdev)
>> +{
>> +    struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
>> +    struct device *dev = &pdev->dev;
>> +    struct cgbc_hwmon_data *data;
>> +    struct device *hwmon_dev;
>> +    int ret;
>> +
>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    data->cgbc = cgbc;
>> +
>> +    platform_set_drvdata(pdev, data);
> 
> What is this used for ? There are no suspend/resume functions,
> so I don't see the use case.

It's useless indeed.

Regards,

Thomas

